#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
将 results/*.md 中“与当前 case 定义可比”的历史结果，导入为 results/runs/*.json。

目标：
- 只导入能映射到现有 case_defs 的项，避免把旧脚本（如 randrw@QD256）塞进对比 UI 里造成噪音
- 从 md 中提取：iops / bw(MiB/s) / clat p95/p99（统一输出为 ms float）
- 输出格式与 run-fio.sh 生成的 run JSON 尽量一致，供 aggregate_runs.py 直接聚合
"""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import re
from dataclasses import dataclass
from datetime import datetime, timezone
from glob import glob
from typing import Any, Dict, Iterable, List, Optional, Tuple


def canonical_json(obj: Any) -> str:
    return json.dumps(obj, ensure_ascii=False, sort_keys=True, separators=(",", ":"))


def sha256_20(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()[:20]


def compute_system_hash(system: str) -> str:
    payload = f"fio-tests/system/v1\0{system}".encode("utf-8")
    return sha256_20(payload)


def normalize_ioengine(ioengine_raw: str) -> str:
    return "native_aio" if ioengine_raw in ("posixaio", "libaio") else ioengine_raw


def compute_case_key(case_sig: Dict[str, Any]) -> str:
    payload = canonical_json(case_sig).encode("utf-8")
    return sha256_20(b"fio-tests/case/v2\0" + payload)


def md_sha8(text: str) -> str:
    return hashlib.sha256(text.encode("utf-8", errors="ignore")).hexdigest()[:8]


def parse_float_with_suffix(v: str) -> Optional[float]:
    s = v.strip()
    m = re.fullmatch(r"([0-9]+(?:\.[0-9]+)?)([kKmMgG])?", s)
    if not m:
        return None
    base = float(m.group(1))
    suf = (m.group(2) or "").lower()
    mul = 1.0
    if suf == "k":
        mul = 1000.0
    elif suf == "m":
        mul = 1000_000.0
    elif suf == "g":
        mul = 1000_000_000.0
    return base * mul


def bw_to_mib_s(token: str) -> Optional[float]:
    """
    支持 fio 常见输出：
    - 77.7MiB/s
    - 3313KiB/s
    - 6530B/s
    - 129278KB/s (fio 2.x 常见；近似视为 KiB/s)
    """
    s = token.strip()
    m = re.fullmatch(r"([0-9]+(?:\.[0-9]+)?)([A-Za-z]+)/s", s)
    if not m:
        return None
    val = float(m.group(1))
    unit = m.group(2)
    unit_norm = unit.replace("i", "").upper()  # KiB->KB, MiB->MB
    if unit_norm == "B":
        return val / (1024.0 * 1024.0)
    if unit_norm == "KB":
        return val / 1024.0
    if unit_norm == "MB":
        return val
    if unit_norm == "GB":
        return val * 1024.0
    return None


def parse_bs_to_str(bs_raw: str) -> Optional[str]:
    """
    将 fio header 中的 bs 表达式归一到脚本用的字符串，如 4k/128k/1M/4M。
    """
    s = bs_raw.strip()
    # 常见：bs=(R) 4096B-4096B, 或 bs=4K-4K/4K-4K/4K-4K
    m = re.search(r"(\d+)\s*(B|KiB|MiB|GiB|K|M|G)", s)
    if not m:
        return None
    n = int(m.group(1))
    unit = m.group(2)
    if unit == "B":
        if n == 4096:
            return "4k"
        if n % 1024 == 0:
            # 例如 131072B -> 128k
            return f"{n // 1024}k"
        return None
    if unit in ("K", "KiB"):
        # 例如 1024KiB -> 1M, 4096KiB -> 4M
        if n % 1024 == 0:
            return f"{n // 1024}M"
        return f"{n}k"
    if unit in ("M", "MiB"):
        return f"{n}M"
    if unit in ("G", "GiB"):
        return f"{n}G"
    return None


def parse_date_to_utc_iso(dow_mon: str) -> Optional[str]:
    """
    fio 输出中没有时区信息，这里按 UTC 处理以保证排序一致。
    例：Fri Dec 12 23:29:35 2025
    """
    try:
        dt = datetime.strptime(dow_mon, "%a %b %d %H:%M:%S %Y").replace(tzinfo=timezone.utc)
        return dt.replace(microsecond=0).isoformat().replace("+00:00", "Z")
    except Exception:
        return None


def iso_to_compact(ts_iso: str) -> str:
    dt = datetime.strptime(ts_iso, "%Y-%m-%dT%H:%M:%SZ").replace(tzinfo=timezone.utc)
    return dt.strftime("%Y%m%dT%H%M%SZ")


@dataclass
class ParsedJob:
    rw: str
    op: str  # read|write
    bs: str
    qd: int
    ioengine_raw: str
    runtime_s: Optional[int]
    timestamp_iso: Optional[str]
    iops: Optional[float]
    bw_mib_s: Optional[float]
    clat_p95_ms: Optional[float]
    clat_p99_ms: Optional[float]


def parse_jobs_from_md(text: str) -> List[ParsedJob]:
    """
    解析 md 中 fio 输出块（粗粒度，按 job 分割）。
    只覆盖当前仓库里历史 md 的主要格式。
    """
    jobs: List[ParsedJob] = []

    # 找出每个 “(groupid=0, jobs=...) ... <date>” 的位置，并向上回溯找对应的 “(g=0): rw=..., bs=..., ioengine=..., iodepth=...”
    group_re = re.compile(
        r"^(?P<name>\S+): \(groupid=0, jobs=\d+\):.*?: (?P<date>(?:Mon|Tue|Wed|Thu|Fri|Sat|Sun) (?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) \d{1,2} \d{2}:\d{2}:\d{2} \d{4})$",
        re.M,
    )
    header_re = re.compile(
        r"^(?P<name>\S+): \(g=0\):.*?rw=(?P<rw>\S+),.*?\bbs=(?P<bs>[^,]+).*?\bioengine=(?P<ioengine>\S+),.*?\biodepth=(?P<qd>\d+)",
        re.M,
    )

    # op 行两种格式：
    # fio3: "read: IOPS=126, BW=126MiB/s ..."
    fio3_op_re = re.compile(r"^\s*(read|write):\s*IOPS=([^,]+),\s*BW=([^\s]+)", re.M)
    # fio2: "read : io=..., bw=129278KB/s, iops=126, runt=120065msec"
    fio2_op_re = re.compile(r"^\s*(read|write)\s*:\s*io=.*?\bbw=([^,\s]+),\s*iops=([^,\s]+)", re.M)

    # runtime：fio3 常在 "(.../120001msec)"，fio2 在 "runt=120019msec"
    fio3_rt_re = re.compile(r"\((?:[^)]*/)?(\d+)msec\)")
    fio2_rt_re = re.compile(r"\brunt=(\d+)msec\b")
    fio_run_re = re.compile(r"\brun=(\d+)-\d+msec\b")

    # clat percentiles unit
    per_unit_re = re.compile(r"clat percentiles \((nsec|usec|msec)\):")
    p95_re = re.compile(r"95\.00th=\[\s*(\d+)\]")
    p99_re = re.compile(r"99\.00th=\[\s*(\d+)\]")

    # 为了拿到完整 job block，我们用 groupid match 的 span 到下一次 groupid 或文本结尾
    group_matches = list(group_re.finditer(text))
    for idx, gm in enumerate(group_matches):
        start = gm.start()
        end = group_matches[idx + 1].start() if idx + 1 < len(group_matches) else len(text)
        block = text[start:end]

        name = gm.group("name")
        ts_iso = parse_date_to_utc_iso(gm.group("date"))

        # 回溯 header（在 groupid 之前的若干行）
        header = None
        # 从 start 往前找最后一个匹配同名的 header
        back = text[max(0, start - 2000) : start]
        for hm in header_re.finditer(back):
            if hm.group("name") == name:
                header = hm
        if header is None:
            continue

        rw = header.group("rw")
        bs = parse_bs_to_str(header.group("bs"))
        qd = int(header.group("qd"))
        ioengine_raw = header.group("ioengine")

        if rw in ("randread", "read"):
            op = "read"
        elif rw in ("randwrite", "write"):
            op = "write"
        else:
            # randrw 等混合模式：本脚本默认不导入（避免污染当前 UI 的 case 列表）
            continue

        # op line: prefer fio3 style, fallback to fio2 style
        iops = None
        bw_mib_s = None
        m3 = fio3_op_re.search(block)
        if m3:
            iops = parse_float_with_suffix(m3.group(2))
            bw_mib_s = bw_to_mib_s(m3.group(3))
        else:
            m2 = fio2_op_re.search(block)
            if m2:
                bw_mib_s = bw_to_mib_s(m2.group(2))
                iops = parse_float_with_suffix(m2.group(3))

        # runtime
        runtime_s = None
        for rx in (fio2_rt_re, fio_run_re):
            m = rx.search(block)
            if m:
                runtime_s = int(round(int(m.group(1)) / 1000.0))
                break
        if runtime_s is None:
            m = fio3_rt_re.search(block)
            if m:
                runtime_s = int(round(int(m.group(1)) / 1000.0))

        # percentiles
        clat_p95_ms = None
        clat_p99_ms = None
        unit_m = per_unit_re.search(block)
        if unit_m:
            unit = unit_m.group(1)
            mul_ms = 1.0
            if unit == "nsec":
                mul_ms = 1.0 / 1_000_000.0
            elif unit == "usec":
                mul_ms = 1.0 / 1000.0
            elif unit == "msec":
                mul_ms = 1.0
            p95 = p95_re.search(block)
            p99 = p99_re.search(block)
            if p95:
                clat_p95_ms = float(p95.group(1)) * mul_ms
            if p99:
                clat_p99_ms = float(p99.group(1)) * mul_ms

        if bs is None:
            continue
        jobs.append(
            ParsedJob(
                rw=rw,
                op=op,
                bs=bs,
                qd=qd,
                ioengine_raw=ioengine_raw,
                runtime_s=runtime_s,
                timestamp_iso=ts_iso,
                iops=iops,
                bw_mib_s=bw_mib_s,
                clat_p95_ms=clat_p95_ms,
                clat_p99_ms=clat_p99_ms,
            )
        )

    return jobs


def build_case_sig(job: ParsedJob) -> Dict[str, Any]:
    # legacy md 基本都是固定 1G 测试文件
    return {
        "rw": job.rw,
        "bs": job.bs,
        "qd": int(job.qd),
        "numjobs": 1,
        "direct": 1,
        "ioengine": normalize_ioengine(job.ioengine_raw),
        "fdatasync": 0,
        "rwmixread": None,
        "time_based": 1,
        "runtime_s": job.runtime_s,
        "size_policy": {"mode": "fixed", "fixed_bytes": 1024 * 1024 * 1024},
    }


def snap_runtime(runtime_s: Optional[int], allowed: List[int]) -> Optional[int]:
    if runtime_s is None:
        return None
    if not allowed:
        return runtime_s
    best = None
    best_diff = None
    for a in allowed:
        diff = abs(runtime_s - a)
        tol = max(2, int(round(a * 0.10)))
        if diff > tol:
            continue
        if best is None or diff < best_diff:
            best = a
            best_diff = diff
    return best if best is not None else runtime_s


def main() -> int:
    parser = argparse.ArgumentParser(description="Import legacy results/*.md into results/runs/*.json (only comparable cases).")
    parser.add_argument("--md-dir", default="results", help="Directory containing legacy *.md")
    parser.add_argument("--runs-dir", default="results/runs", help="Directory to write run JSON files")
    parser.add_argument("--data-json", default="results/data.json", help="Existing aggregated data.json for case_defs filter")
    parser.add_argument("--dry-run", action="store_true", help="Only print what would be imported")
    args = parser.parse_args()

    md_paths = sorted(glob(os.path.join(args.md_dir, "*.md")))
    os.makedirs(args.runs_dir, exist_ok=True)

    # 只导入当前 case_defs 里已存在的 case（避免旧参数的 case 混进 UI）
    case_defs: Dict[str, Any] = {}
    if os.path.exists(args.data_json):
        try:
            doc = json.load(open(args.data_json, "r", encoding="utf-8"))
            case_defs = doc.get("case_defs") or {}
        except Exception:
            case_defs = {}
    allowed_case_keys = set(case_defs.keys())
    allowed_runtimes = sorted(
        {int(s.get("runtime_s")) for s in case_defs.values() if isinstance(s, dict) and s.get("runtime_s") is not None}
    )

    wrote = 0
    skipped = 0

    for md_path in md_paths:
        base = os.path.basename(md_path)
        system = os.path.splitext(base)[0]
        text = open(md_path, "r", encoding="utf-8", errors="ignore").read()
        jobs = parse_jobs_from_md(text)

        cases = []
        timestamps = []
        engine_raw = None
        for j in jobs:
            case_sig = build_case_sig(j)
            case_sig["runtime_s"] = snap_runtime(case_sig.get("runtime_s"), allowed_runtimes)
            ck = compute_case_key(case_sig)
            if allowed_case_keys and ck not in allowed_case_keys:
                continue
            timestamps.append(j.timestamp_iso)
            if engine_raw is None:
                engine_raw = j.ioengine_raw

            ops: Dict[str, Any] = {}
            if j.op in ("read", "write") and (j.iops is not None or j.bw_mib_s is not None):
                ops[j.op] = {
                    "iops": j.iops,
                    "bw_mib_s": j.bw_mib_s,
                    "clat_p95_ms": j.clat_p95_ms,
                    "clat_p99_ms": j.clat_p99_ms,
                }
            if not ops:
                continue

            cases.append(
                {
                    "case_key": ck,
                    "case": case_sig,
                    "ioengine_raw": j.ioengine_raw,
                    "size_effective_bytes": 1024 * 1024 * 1024,
                    "fio_json_path": None,
                    "ops": ops,
                }
            )

        if not cases:
            skipped += 1
            continue

        # 取最大时间戳（代表该 md 的“完成时刻”）
        ts_iso_candidates = [t for t in timestamps if t]
        ts_iso = max(ts_iso_candidates) if ts_iso_candidates else None
        if ts_iso is None:
            # fallback: file mtime
            dt = datetime.fromtimestamp(os.path.getmtime(md_path), tz=timezone.utc)
            ts_iso = dt.replace(microsecond=0).isoformat().replace("+00:00", "Z")
        ts_compact = iso_to_compact(ts_iso)

        system_hash = compute_system_hash(system)
        rid = f"{ts_compact}_{system_hash}_legacy_{md_sha8(text)}"
        out_path = os.path.join(args.runs_dir, f"{rid}.json")

        payload = {
            "repo": "edwardtoday/fio-tests",
            "mode": "legacy_import",
            "run": {
                "run_id": rid,
                "system": system,
                "system_hash": system_hash,
                "timestamp": ts_iso,
                "timestamp_compact": ts_compact,
                "invoked_profile": "legacy_md",
                "engine": engine_raw,
                "target_dir": None,
                "out_dir": None,
            },
            "cases": cases,
        }

        if args.dry_run:
            print(f"[dry-run] {md_path} -> {out_path} cases={len(cases)}")
            continue

        if os.path.exists(out_path):
            # deterministic rid -> stable output; if already exists, skip
            skipped += 1
            continue

        with open(out_path, "w", encoding="utf-8") as f:
            json.dump(payload, f, ensure_ascii=False, indent=2, sort_keys=True)
            f.write("\n")
        wrote += 1

    print(f"Imported legacy md: wrote={wrote}, skipped={skipped}, md_total={len(md_paths)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
