#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
从 results/runs/*.json 聚合生成 results/data.json。

设计目标：
- 只依赖结构化 JSON（不解析原始 fio 文本日志）
- 以 case_key 作为横向对比的最小单位
- 输出结构化索引，方便 index.html 做筛选与 “only latest per system”
"""

from __future__ import annotations

import argparse
import hashlib
import json
import os
from dataclasses import dataclass
from datetime import datetime, timezone
from glob import glob
from typing import Any, Dict, List, Optional, Tuple


def utc_now_iso() -> str:
    return datetime.now(timezone.utc).replace(microsecond=0).isoformat().replace("+00:00", "Z")


def load_json(path: str) -> Any:
    with open(path, "r", encoding="utf-8") as f:
        return json.load(f)


def canonical_json(obj: Any) -> str:
    return json.dumps(obj, ensure_ascii=False, sort_keys=True, separators=(",", ":"))


def sha256_20(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()[:20]


def normalize_ioengine(ioengine: Any) -> str:
    v = "" if ioengine is None else str(ioengine)
    # macOS: posixaio, Linux: libaio. Treat them as the same "native aio" case for cross-OS compare.
    if v in ("posixaio", "libaio"):
        return "native_aio"
    return v


def normalize_case_sig(case_sig: Dict[str, Any]) -> Dict[str, Any]:
    sig = dict(case_sig or {})
    if "ioengine" in sig:
        sig["ioengine"] = normalize_ioengine(sig.get("ioengine"))
    return sig


def compute_case_key(case_sig: Dict[str, Any]) -> str:
    sig_norm = normalize_case_sig(case_sig)
    payload = canonical_json(sig_norm).encode("utf-8")
    return sha256_20(b"fio-tests/case/v2\0" + payload)


def safe_float(val: Any) -> Optional[float]:
    if val is None:
        return None
    try:
        return float(val)
    except (TypeError, ValueError):
        return None


def safe_int(val: Any) -> Optional[int]:
    if val is None or val == "":
        return None
    try:
        return int(val)
    except (TypeError, ValueError):
        return None


@dataclass(frozen=True)
class RunMeta:
    run_id: str
    system: str
    system_hash: str
    timestamp: str
    invoked_profile: Optional[str]
    engine: Optional[str]


def parse_run_meta(doc: Dict[str, Any]) -> RunMeta:
    run = doc.get("run") or {}
    run_id = str(run.get("run_id") or "")
    system = str(run.get("system") or "")
    system_hash = str(run.get("system_hash") or "")
    timestamp = str(run.get("timestamp") or "")
    invoked_profile = run.get("invoked_profile")
    engine = run.get("engine")

    if not run_id or not system or not timestamp:
        raise ValueError("invalid run json: missing run.run_id/run.system/run.timestamp")

    return RunMeta(
        run_id=run_id,
        system=system,
        system_hash=system_hash,
        timestamp=timestamp,
        invoked_profile=str(invoked_profile) if invoked_profile is not None else None,
        engine=str(engine) if engine is not None else None,
    )


def aggregate(runs_dir: str) -> Dict[str, Any]:
    pattern = os.path.join(runs_dir, "*.json")
    paths = sorted(glob(pattern))

    run_rows: List[Dict[str, Any]] = []
    case_defs: Dict[str, Dict[str, Any]] = {}
    measurements: List[Dict[str, Any]] = []

    for path in paths:
        doc = load_json(path)
        run_meta = parse_run_meta(doc)

        run_rows.append(
            {
                "run_id": run_meta.run_id,
                "system": run_meta.system,
                "system_hash": run_meta.system_hash,
                "timestamp": run_meta.timestamp,
                "invoked_profile": run_meta.invoked_profile,
                "engine": run_meta.engine,
                "source_path": os.path.relpath(path),
            }
        )

        for case_entry in doc.get("cases") or []:
            case_sig_raw = case_entry.get("case") or {}
            case_sig = normalize_case_sig(case_sig_raw)
            case_key = compute_case_key(case_sig_raw)
            size_effective_bytes = safe_int(case_entry.get("size_effective_bytes"))

            if not case_key:
                continue

            if case_key in case_defs:
                if canonical_json(case_defs[case_key]) != canonical_json(case_sig):
                    # 需求允许历史保留；case_key 冲突意味着签名字段定义不一致，应当保留首个并标记冲突。
                    case_defs[case_key]["_conflict"] = True
            else:
                case_defs[case_key] = case_sig

            ops = case_entry.get("ops") or {}
            for op_name, metrics in ops.items():
                if op_name not in ("read", "write"):
                    continue
                m = metrics or {}
                measurements.append(
                    {
                        "run_id": run_meta.run_id,
                        "system": run_meta.system,
                        "system_hash": run_meta.system_hash,
                        "timestamp": run_meta.timestamp,
                        "case_key": case_key,
                        "op": op_name,
                        "iops": safe_float(m.get("iops")),
                        "bw_mib_s": safe_float(m.get("bw_mib_s")),
                        "clat_p95_ms": safe_float(m.get("clat_p95_ms")),
                        "clat_p99_ms": safe_float(m.get("clat_p99_ms")),
                        "size_effective_bytes": size_effective_bytes,
                    }
                )

    run_rows.sort(key=lambda r: (r["timestamp"], r["run_id"]))
    measurements.sort(key=lambda r: (r["system"], r["case_key"], r["op"], r["timestamp"], r["run_id"]))

    systems: Dict[str, Dict[str, Any]] = {}
    for r in run_rows:
        sys_name = r["system"]
        entry = systems.get(sys_name)
        if entry is None:
            systems[sys_name] = {
                "system": sys_name,
                "system_hash": r.get("system_hash", ""),
                "latest_run_id": r["run_id"],
                "latest_timestamp": r["timestamp"],
                "run_count": 1,
            }
        else:
            entry["run_count"] = int(entry["run_count"]) + 1
            # 以 timestamp 为主，run_id 为辅
            if (r["timestamp"], r["run_id"]) >= (entry["latest_timestamp"], entry["latest_run_id"]):
                entry["latest_run_id"] = r["run_id"]
                entry["latest_timestamp"] = r["timestamp"]

    return {
        "generated_at": utc_now_iso(),
        "schema": "fio-tests/data/v3",
        "runs_dir": os.path.relpath(runs_dir),
        "systems": list(systems.values()),
        "runs": run_rows,
        "case_defs": case_defs,
        "measurements": measurements,
    }


def main() -> int:
    parser = argparse.ArgumentParser(description="Aggregate fio run JSON files into results/data.json")
    parser.add_argument("--runs-dir", default="results/runs", help="Directory containing run JSON files")
    parser.add_argument("--out", default="results/data.json", help="Output JSON path")
    args = parser.parse_args()

    runs_dir = args.runs_dir
    if not os.path.isdir(runs_dir):
        os.makedirs(runs_dir, exist_ok=True)

    data = aggregate(runs_dir)
    out_path = args.out
    os.makedirs(os.path.dirname(out_path) or ".", exist_ok=True)

    # Preserve legacy rows moved from index.html (if present).
    legacy_rows = None
    if os.path.exists(out_path):
        try:
            existing = load_json(out_path)
            if isinstance(existing, dict) and isinstance(existing.get("legacy_rows"), list):
                legacy_rows = existing.get("legacy_rows")
        except Exception:
            legacy_rows = None
    if legacy_rows is not None:
        data["legacy_rows"] = legacy_rows

    with open(out_path, "w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=2, sort_keys=True)
        f.write("\n")

    print(f"Wrote {out_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
