# Maintainer tooling (not part of the published toolkit)

## `typescript-toolchain/`

Node.js dev dependencies for type-checking and unit-testing [`src/quiz-engine.ts`](../src/quiz-engine.ts). Keeps the repository root free of `package.json` / lockfile clutter.

From that directory:

```bash
npm ci
npm run typecheck
npm test
```

GitHub Actions runs the same commands on every push and pull request.
