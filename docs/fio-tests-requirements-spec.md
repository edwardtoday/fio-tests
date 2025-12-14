# fio-tests 需求规格（草案）

目标：让同事/网友在任意机器上一键跑 `fio`，**无需 Git/GitHub 凭证**，即可把结构化结果提交到 `edwardtoday/fio-tests`，并由自动化流程更新 `index.html` 的交互式汇总页面。

本文档只定义需求与协议，不实现细节；后续按本文逐步落地。

## 角色与原则

- **跑测试的人**：只需要能执行脚本；默认不上传；上传时只输入 “系统名”。
- **维护者（你）**：只在 n8n 配置 GitHub 凭证与 shared secret；仓库更新流程都在 n8n/GitHub Actions 完成。
- **核心原则**
  - “系统名”就是用户输入的原始字符串，不做任何规范化/规则化。
  - **保留历史**：同一系统名可有多次 run 记录。
  - 横向对比单位是 **case（测试项）**，不是 profile 名称；只要 case 参数签名一致就可比较。
  - 只存结构化 JSON；不强制生成 Markdown；页面从结构化数据渲染。

## 测试集合（profiles）

profile 仅用于“选择要跑哪些 case 的快捷方式”，不参与横向对比逻辑。

### quick（来料快测）

- 4K `randread` @QD1
- 4K `randwrite` @QD1
- 1M `read`（顺序）
- 1M `write`（顺序）

### standard（通用基线）

- 4K `randread` / `randwrite` @QD1、@QD4
- 4K `randrw` 70/30 @QD1、@QD4
- 1M `read`（顺序）
- 1M `write`（顺序）

### full（导入新型号/深挖）

在 `standard` 之外增加：

- **持续顺序写**
  - 目标写入量：16GiB
  - 若可用空间不足：按可用空间的 60% 写入
  - 记为一个独立 case（由 `size_policy` 确定可比性）
- **持续随机写**
  - 4K `randwrite`，runtime=10min（600s）
  - 建议 size 也采用策略（例如 `min(4GiB, 60% free)`），避免只在缓存中循环导致失真

### db（数据库/写入落盘）

- 4K/8K/16K 的随机读写 @QD1、@QD4
- `fdatasync`（落盘路径）写入测试
  - 建议用 `direct=0` + `ioengine=sync` + `fdatasync=1`
  - 这是一个独立维度，case_key 必须能区分（避免与普通 write 混淆）

## 指标与单位（metrics）

### 必须输出的指标

每个 case 必须至少输出：

- `iops`
- `bw_mib_s`（MiB/s）
- `clat_p95_ms`（clat 95th percentile，毫秒浮点）
- `clat_p99_ms`（clat 99th percentile，毫秒浮点）

说明：

- 指标按 **op 维度** 记录：`read` / `write`（例如 `randrw` 会同时包含 read 与 write）。
- 随机类（`randread/randwrite/randrw`）的延迟必须输出；顺序类也可输出但 UI 可默认隐藏。
- 数据层统一使用 `ms` 浮点；展示层可对 `< 1ms` 自动格式化成 `µs`（仅显示，不改数据）。

## case（测试项）建模与可比性

### case_key

横向对比的主键为 `case_key`。只要 `case_key` 相同，就认为该测试项可比较。

`case_key` 必须包含（至少）以下签名字段：

- `rw`（randread/randwrite/randrw/read/write）
- `bs`
- `qd`（iodepth）
- `numjobs`
- `direct`
- `ioengine`（用于区分 libaio/posixaio/sync 等路径差异）
- `fdatasync`（0/1）
- `rwmixread`（仅 randrw 时；其他为 null）
- `time_based`（0/1）
- `runtime_s`
- `size_policy`（见下）

#### case_key 生成规范（建议定案）

- 输入：case 签名字段组成的对象（见上），使用 **canonical JSON**（UTF-8、key 排序、无多余空格）
- 域分离前缀：`fio-tests/case/v1\0`
- 算法：SHA‑256
- 输出：小写 hex，取前 20 位（80 bit）

伪代码：

```
case_key = sha256("fio-tests/case/v1\0" + canonical_json(case_sig)).hex_lower[0:20]
```

### size_policy

为保证“策略一致即可比较”，size 需要拆成：

- `size_policy`：可比较的策略描述（参与 `case_key`）
- `size_effective_bytes`：实际跑到的大小（不参与 `case_key`，但用于展示与审计）

建议的 `size_policy` 形态：

- 固定：`{ "mode": "fixed", "bytes": 1073741824 }`
- 固定或按可用空间百分比：`{ "mode": "fixed_or_pct_free", "fixed_bytes": 17179869184, "pct_free": 60 }`
- 取两者最小：`{ "mode": "min_of", "items": [ {fixed...}, {pct_free...} ] }`

## run（一次执行）建模

一次脚本执行产生一个 run：

- `system`：用户输入的原始字符串
- `timestamp`：UTC 时间（ISO8601；同时提供文件名安全格式）
- `run_id`：`<timestamp_compact>_<system_hash>`
- `meta`：环境信息（尽量采集，不强制）
- `cases[]`：本次执行产生的所有 case 结果（`full` 包含 `standard`/`quick` 的 case 是允许且推荐的）

### system_hash 规范（已定案）

用于 `run_id`、去重与归档，不用于生成文件名规则。

- 输入：`system` 原始字符串（不 trim、不改大小写、不做规范化）
- 编码：UTF‑8 字节
- 域分离前缀：`fio-tests/system/v1\0`（`\0` 为字节 0）
- 算法：SHA‑256
- 输出：小写 hex，取前 20 位（80 bit）

伪代码：

```
system_hash = sha256("fio-tests/system/v1\0" + utf8(system)).hex_lower[0:20]
run_id = timestamp_utc_compact + "_" + system_hash
```

## 数据存储（仓库内）

不强制生成 Markdown；只存结构化 JSON。

建议落盘路径：

- `results/runs/<run_id>.json`：一次 run 的完整结构化结果（包含 cases[]）
- 可选：`results/data.json`：由 n8n 聚合生成的索引数据（给 `index.html` 使用）

## index.html（汇总页面）行为

页面以 system 为行，通过筛选器选择测试项维度（rw/bs/qd/mix/direct/fdatasync/runtime/size_policy...）。

默认行为：

- `Only show latest result for the same target` 开关 **默认开启**
- “latest” 的定义：对于当前筛选的 `case_key`，每个 `system` 取**最新一个包含该 case_key 的 run**（避免最新 run 没跑该 case 导致空值）

页面应支持：

- 关闭 latest 开关后，查看该 system 的历史 run（按时间排序，必要时分页）
- 指标显示至少包含：IOPS、MiB/s、p95、p99（随机类）

## 上报流程（n8n webhook）

### 脚本交互（给跑测试的人）

- 默认不上传
- 选择上传后：
  - 输入 system（字符串原样记录）

### 鉴权

- 使用 shared secret（由维护者在 n8n 配置）
- 脚本以 header 携带（例如 `Authorization: Bearer <secret>` 或自定义 header）

### 载荷（payload）

只上传结构化 JSON（不上传 raw logs）。

建议字段：

- `repo`: `"edwardtoday/fio-tests"`（或 n8n 固定配置）
- `run`: `{ run_id, system, timestamp, meta... }`
- `cases[]`: 每个 case 的 `case_key`、参数与指标

### n8n 职责

收到 webhook 后：

1) 校验 shared secret
2) 写入 `results/runs/<run_id>.json`
3) 将变更提交到 GitHub（至少包含新增的 `results/runs/<run_id>.json`）
4) 由 GitHub Actions 自动聚合生成/更新 `results/data.json`（触发条件：push `results/runs/*.json`）
5) `index.html` 直接读取 `results/data.json` 渲染（无需 n8n 注入/改写 HTML）
   - 可选：直接 push main（省事）
   - 可选：开 PR + Action 校验（更安全）
