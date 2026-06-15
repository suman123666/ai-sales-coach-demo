# AI销冠陪练中心

面向门店销售团队的 AI 训练闭环 demo：管理员配置销售场景和评分维度，员工与 AI 客户进行实战对话，系统自动生成多维评分、复盘建议和团队排行榜。

> 作品集定位：AI PM 项目展示。重点不是“用了什么技术栈”，而是如何把大模型能力落到一个可演示、可评估、可运营的训练产品里。

## Demo

- 在线演示：部署到 Render 后填写 URL
- PC 端入口：`/`
- 移动端入口：`/m`
- API 健康检查：`/health`

### 演示账号

| 角色 | 账号 | 密码 | 可演示能力 |
|---|---|---|---|
| 管理员 | `admin` | `admin123` | 配置销售场景、评分维度、查看全量记录 |
| 组长 | `leader1` | `leader123` | 查看团队练习记录、排行榜、薄弱维度 |
| 员工 | `user1` | `user123` | 选择场景、完成 AI 陪练、查看评分报告 |

## Product Story

传统销售培训常见三个问题：练习成本高、反馈不及时、团队能力差距难量化。这个 demo 将“培训内容配置、AI 角色扮演、结构化评分、团队复盘”串成闭环：

1. 管理员沉淀真实业务场景，例如新客推介、续卡挽留、价格异议、退费挽留。
2. 员工进入闯关陪练，与 AI 客户进行多轮对话。
3. AI 按专业度、亲和力、应变力、成交力等维度评分，并给出证据化反馈。
4. 组长查看排行榜、未完成名单、团队薄弱维度，用数据安排后续训练。

## AI PM Highlights

- **场景产品化**：每个训练任务包含客户画像、情境、难度、开场白、是否必练和评分权重。
- **Prompt 分层**：客户扮演 prompt 控制客户防御心和难度，评分 prompt 强制输出 JSON 和对话证据。
- **可解释评分**：维度评分必须引用销售原话，避免只给抽象鼓励。
- **运营闭环**：排行榜不是单纯分数排序，而是要求员工完成必练场景后才入榜。
- **公开演示防护**：真实 AI demo 增加每日用户/IP 限流，降低公开链接带来的 API 成本风险。

## Local Setup

### Backend

```powershell
cd backend
pip install -r requirements.txt
$env:QWEN_API_KEY = "your-qwen-api-key"
$env:AI_MODE = "real"
python seed_data.py
python -m uvicorn main:app --port 8001 --reload
```

如不想消耗真实模型，可使用 mock：

```powershell
$env:AI_MODE = "mock"
python -m uvicorn main:app --port 8001 --reload
```

### Frontend

```powershell
cd frontend
npm install
npm run dev
```

浏览器打开 `http://localhost:9528`。H5 移动端为 `http://localhost:9528/#/m`。

## Deploy

推荐使用 Render 的 Docker Web Service。部署说明见 [docs/DEPLOY_RENDER.md](docs/DEPLOY_RENDER.md)。

核心环境变量：

| 变量 | 说明 |
|---|---|
| `QWEN_API_KEY` | 通义千问 DashScope API Key |
| `AI_MODE` | `real` 使用真实 AI，`mock` 使用本地固定回复 |
| `AI_DAILY_LIMIT_PER_USER` | 每个演示账号每日 AI 调用上限 |
| `AI_DAILY_LIMIT_PER_IP` | 每个 IP 每日 AI 调用上限 |
| `AUTO_SEED_DEMO` | 首次启动无用户时自动写入演示数据 |

## Docs

- [PRD](docs/PRD.md)
- [演示脚本](docs/DEMO.md)
- [Render 部署说明](docs/DEPLOY_RENDER.md)

## Tech Stack

- Frontend: Vue 2, Vue Router, Vuex, Element UI, Vant, ECharts
- Backend: FastAPI, aiosqlite, SQLite
- AI: Qwen via DashScope OpenAI-compatible API
- Deploy: Docker + Render
