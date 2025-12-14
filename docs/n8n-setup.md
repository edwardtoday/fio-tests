# n8n 上报通道配置（维护者）

目标：让跑测试的人无需 Git/GitHub 凭证；`run-fio.sh` 产出结构化 JSON 后，可选上传到 n8n webhook；由 n8n 写入 GitHub 仓库 `edwardtoday/fio-tests` 的 `results/runs/*.json`，再由 GitHub Actions 自动聚合更新 `results/data.json`，最终 GitHub Pages 自动展示最新数据。

## 1) 准备 GitHub PAT

在 GitHub 创建 Personal Access Token（PAT），确保对仓库 `edwardtoday/fio-tests` 有写权限。

建议最小权限：

- Fine-grained PAT：只授权该仓库的 `Contents: Read and write`
- Classic PAT：至少 `repo`

## 2) 在 n8n 服务端配置环境变量

当前 n8n workflow 实现通过环境变量读取 secret/token（不会写进 workflow JSON），需要在 n8n 进程环境中配置并重启 n8n 生效：

- `FIO_TESTS_WEBHOOK_SECRET`：shared secret（脚本会以 `Authorization: Bearer <secret>` 发送）
- 可选：
  - `FIO_TESTS_GITHUB_REPO`：默认 `edwardtoday/fio-tests`
  - `FIO_TESTS_GITHUB_BRANCH`：默认 `main`

如果你不方便在部署层设置环境变量/重启 n8n，也可以在 workflow 的 `Set Config` 节点里直接写死 shared secret（不建议公开；需要自行做好轮换）。

## 2.1) 在 n8n Credentials 配置 GitHub

在 n8n 的 `Credentials` 页面新建：

- 类型：GitHub API（credential type：`githubApi`）
- 填入上一步创建的 PAT

然后在 workflow `fio-tests: ingest run JSON` 的 `GitHub - Put file` 节点上选择该 credential（当前已绑定 id：`bskUsl1GTzqYQhQ2`）。

## 3) 启用 n8n workflow

在 n8n UI 中找到 workflow：`fio-tests: ingest run JSON`，切换为 Active。

Webhook URL 见 `https://github.com/edwardtoday/fio-tests` 仓库的 `README.md` 运行说明，或参考 `/Users/qingpei/git/n8n/qingpei-workflows/fio-tests-upload/deployment.json`（内部记录）。

## 4) 端到端验证

在任意机器上执行（示例用 `.` 作为当前目录）：

```sh
FIO_TESTS_WEBHOOK_URL='https://<your-n8n>/webhook/<path>' \
FIO_TESTS_WEBHOOK_SECRET='<secret>' \
curl -fsSL https://raw.githubusercontent.com/edwardtoday/fio-tests/refs/heads/main/run-fio.sh | bash -s -- --profile quick --upload .
```

验证点：

1) GitHub 仓库出现新增 `results/runs/<run_id>.json`
2) GitHub Actions `Aggregate fio runs` 成功执行，并提交 `results/data.json`
3) GitHub Pages 页面 `https://edwardtoday.github.io/fio-tests/` 能看到 runs 模式数据
