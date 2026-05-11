# AGENTS.md — EU-AI-Act-Toolkit

## Branch strategy

| Branch | Purpose |
|---|---|
| `main` | Production stable |
| `codex/main` | Manual Codex work |
| `claude/main` | Manual Claude work |
| `ag/feature-*`| Temporary feature branches for Antigravity IDE (must merge to main) |
| `codex/night-work` | Autonomous Codex via ai-later |
| `claude/night-work` | Autonomous Claude via ai-later |

## Core rules

- Do not push directly to `main` without human review.
- **Antigravity Rule:** Antigravity MUST run from `*-ag` isolated folder. Before any task, run `git pull origin main`, create an `ag/feature-*` branch, and PR to `main` upon completion.
- Do not commit secrets, API keys, or real `.env` files.
- Commit after meaningful changes; push after commit.
