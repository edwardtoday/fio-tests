# fio-tests v2 Backlog（从 M1 开始）

本 backlog 用于“逐步实现并标记完成”。每个条目尽量满足：

- 可交付：用户能感知价值
- 可验证：有明确验收标准
- 可回滚：改动聚焦，避免超大 diff

相关总文档：`docs/fio-tests-v2-requirements-and-plan.md`

---

## M1：System 详情（目标：一点看到某 system 全部结果）

### M1.0 基础设施（导航与状态）

- [x] M1.0.1 新增“system 详情面板/页面”入口（从主表点击 system 打开）
  - 验收：任意 system 单元格点击后，出现详情视图；可返回主视图
- [x] M1.0.2 system 详情与 URL 状态联动（可分享链接直达 system 详情）
  - 验收：复制链接后在新窗口打开，自动进入同一 system 详情视图
- [x] M1.0.3 system 详情与语言切换联动（中/英一致）
  - 验收：切换语言后详情视图所有文案一致切换

### M1.1 Latest 全量表（核心交付）

- [x] M1.1.1 生成某 system 的 “latest per case/op” 全量列表
  - 说明：latest 定义为“该 system 对每个 case_key/op 选择最新包含该 case 的 run”
  - 验收：同一 system 在页面能看到其全部 case 的最新值（含 iops/bw/p95/p99）
- [x] M1.1.2 全量表分组展示（至少：随机、顺序、落盘、持续写）
  - 验收：用户能在详情里快速定位到想看的类别；不需要滚很久
- [x] M1.1.3 每行可追溯（展示 run_id/timestamp；可一键打开 run.json）
  - 验收：任意 case 行可打开对应 `results/runs/<run_id>.json`

### M1.2 历史与波动（用于排查异常）

- [x] M1.2.1 在 system 详情中，选择某个 case 后显示最近 N 次历史（折线）
  - 默认：N=10（可调）
  - 验收：能看到 iops/bw/lat 的变化趋势，并可切换 metric
- [x] M1.2.2 标注异常点（简单规则即可：例如偏离最近中位数超过阈值）
  - 验收：异常点有视觉标记，鼠标 hover 可看到 run_id/timestamp

### M1.3 两次 run 对比（diff）

- [x] M1.3.1 选择两个 run（同 system）进行 diff
  - 验收：能看到哪些 case 变快/变慢（百分比），并能按变动幅度排序
- [x] M1.3.2 diff 支持按 metric 切换（iops/bw/p95/p99）
  - 验收：切 metric 后 diff 表格与图表同步更新

---

## M2：可比性与可信度（目标：避免误比）

> 先占位，等 M1 稳定后再细拆。

- [x] M2.0.1 可比性提示：当筛选结果混合 runtime/direct/fdatasync/ioengine/size_policy 时提示
- [x] M2.0.2 提供“一键修正”建议（例如固定 runtime_s=120）
- [x] M2.0.3 展示 meta（fio/kernel/fs/mount/设备标识等）并在差异时提示
- [x] M2.0.4 维护者治理：隐藏/标记垃圾 run（不删除原始数据）

---

## M3：横向对比增强（目标：读者更爽）

- [ ] M3.0.1 Scoreboard 增加 rank / vs best%（可开关）
- [ ] M3.0.2 baseline system：设置基准机并显示 vs baseline%
- [ ] M3.0.3 导出 CSV（当前视图）

---

## M4：规模化（目标：runs 多了仍好用）

- [ ] M4.0.1 data.json 索引增强（前端无需全量遍历）
- [ ] M4.0.2 前端按需加载 run.json（点击详情才加载）
- [ ] M4.0.3 history/compare 大表分页或虚拟列表
