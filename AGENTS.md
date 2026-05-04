# Agent and contributor notes (EU-AI-Act-Toolkit)

## Branching

Ship substantive work on **`main`**. This repo disables Dependabot version-update PRs; dependency bumps are normal commits on `main` (see `.github/CONTRIBUTING.md` and `.cursor/rules/eu-ai-act-toolkit-main-only.mdc`).

## Checks before push

```bash
./scripts/check-toolkit-quality.sh
cd .github/node-toolchain && npm ci && npm run typecheck && npm test
```

CI mirrors these steps plus ShellCheck, HTML validation, and Python registry/schema checks.

## Layout

| Area | Role |
|------|------|
| `docs/` | GitHub Pages static site (`*.html`, `assets/`) |
| `toolkit/` | Markdown templates, checklists, packs |
| `src/` | TypeScript quiz engine; tests `*.test.ts` excluded from `tsc`, run with Vitest |
| `.github/node-toolchain/` | `npm ci`, typecheck, Vitest |
| `tools/` | Python validators, manifest builder/sync |
| `scripts/` | `check-toolkit-quality.sh`, `required-toolkit-files.txt`, `quality-lib.sh` |

## Local-only files

`toolkit/examples/progress-notes/**/toolkit-progress-note-*.md` is **gitignored**; do not commit bulk generated notes.
