# fio-tests v2 需求与计划（仅中文）

本文档是 fio-tests 的 v2 版“需求 + 产品/交付计划”。它面向两个目标：

1) 让任何人（同事/网友）在任意机器上跑 `run-fio.sh` 并可选上传，**无需 Git/GitHub 凭证**  
2) 让 GitHub Pages 的 Web UI 成为“存储基础性能横向对比”的入口：开箱即用、可追溯、可分享、可规模化

> 说明：v1 需求仍保留在 `docs/fio-tests-requirements-spec.md`，但后续实现以 v2 为准。

---

## 1. 背景与问题

当前项目已经具备：

- 结构化结果（run JSON）与聚合索引（`results/data.json`）
- GitHub Pages Web UI：多模式浏览（scoreboard/matrix/explorer）、热力色、排序联动、语言切换、可分享链接

但仍存在典型产品问题：

- **任务路径不够直达**：横向对比很强，但“看某一台系统的全部结果”“排查波动/异常”不够一跳到位  
- **可比性与可信度缺失**：当口径混在一起（runtime/direct/fdatasync/ioengine/size_policy），容易误比而用户无感知  
- **规模化风险**：随着 runs 变多，前端一次性加载/遍历全量会变慢；垃圾数据与异常 run 缺少治理通道

---

## 2. 目标（Goals）

### 2.1 产品目标

- Web UI 能支持三类核心任务：
  1) 横向对比：不同 system 在同一 workload 下的对比（默认任务）
  2) 单 system 总览：看到某 system 的“全部 case 结果”（latest + 可切历史）
  3) 排查异常/波动：同 system 同 case 的历史走势/波动，并能定位“可能原因”（参数/环境差异）

### 2.2 工程目标

- 所有结果可追溯：system → run_id → `results/runs/<run_id>.json` → case 签名  
- 结果可分享可复现：URL 能携带视图状态（语言/布局/筛选/metric 等）  
- 数据口径可比：UI 明确提示“当前是否可比/混合口径”，并给出修正建议  
- 可规模化：runs 增长到千级以上，仍能保持良好交互体验（以索引为主、按需加载）

---

## 3. 非目标（Non-goals）

- 不做“复杂评分模型/权重争论”的强制统一（可提供可选的 rank/差值，但默认不把复杂评分作为唯一结论）
- 不把 profile 当作横向对比口径（横向对比以 case 参数签名为准）
- 不在 Web UI 里做权限体系（贡献者上传鉴权在 n8n/shared secret）

---

## 4. 关键概念（v2 统一口径）

### 4.1 case / case_key

- 横向对比单位是 case（测试项），可比性由 `case_key` 决定  
- `case_key` 由 case 签名字段 canonical 化后做 hash（参见 v1 文档中的规范）

### 4.2 run / run_id

- 一次脚本执行产出一个 run，包含多个 case 的结果  
- 允许同一 system 有多次 run，保留历史

### 4.3 可比性（Comparability）

同一页面的“对比结果”必须能够回答：这些值是否来自同一口径？

- 口径关键字段（至少）：`rw/bs/qd/runtime_s/direct/fdatasync/ioengine/rwmixread/size_policy`  
- UI 必须在用户“混合口径”时提示，并提供“固定某个字段”的建议/快捷操作

---

## 5. Web UI v2 产品方案（信息架构）

### 5.1 顶层结构

- 顶栏：语言切换、复制链接、GitHub 入口
- 主区域：三种模式（现有基础上打磨“默认路径”）
  - Scoreboard（默认）：常用 workload 一键横比（热力色 + 排序 + 图表）
  - Explorer：高级筛选（专家模式，保证可比性）
  - Matrix/Compare：多 case × 多 system 的矩阵概览（热力色 + tooltip 可追溯）

### 5.2 必须新增：System 详情（M1）

从任何对比表格点击某 system，进入一个“system dashboard（详情面板/页面）”：

- latest 全量表：按分类呈现该 system 所有可用 case 的最新结果
- run 切换：按时间选择 run（或最近 N 次）
- 同 case 历史：至少支持折线（后续可加入箱线图）
- 详情与追溯：可一键打开 run.json；展示 meta 摘要（fio/version/os/fs/mount/设备标识等）

> 这是 v2 的关键：让“看单个 system 全部结果”从“会用筛选器的人才能做到”变成“一点就到”。

---

## 6. 路线图（Roadmap）

路线图按里程碑推进，详见 `docs/backlog-v2.md`。

### M1：System 详情（最直接提升可用性）

- system dashboard（latest 全量 + 可切历史）
- 两次 run 对比（diff：哪些 case 变快/变慢）

### M2：可比性与可信度（避免误比）

- 口径混合提示 + 修正建议
- meta 展示与差异提示（fio/kernel/fs/mount 等）
- 异常 run 标记/隐藏（维护者治理：维护 `results/moderation.json`，不删除原始数据）

### M3：横向对比增强（读者更爽）

- rank / vs best / vs baseline（可开关）
- CSV 导出当前视图

### M4：规模化（runs 多了仍好用）

- `results/data.json` 索引增强 + 前端按需加载
- history 分页/虚拟列表

---

## 7. 成功标准（验收口径）

### 7.1 体验

- 新用户打开页面 30 秒内能完成一次横向对比（无需理解所有筛选器）
- 3 次点击内进入某 system 的“全部最新 case 结果”

### 7.2 可信与可追溯

- 任意表格单元格都能追溯到对应 run_id 与 case 参数签名
- 混合口径时 UI 明确提示，不让误比“悄悄发生”

### 7.3 性能

- runs 增长后，仍能保持首屏快速可交互（以索引为主、按需加载 run.json）

---

## 8. 实施与协作

- 需求与协议以 v2 文档为准
- 工程拆解以 `docs/backlog-v2.md` 为准：从 M1 开始逐项实现，并在 backlog 中勾选完成
