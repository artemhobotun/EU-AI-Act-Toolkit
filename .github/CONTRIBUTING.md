# ✨ Contributing to the EU AI Act Toolkit

Thanks for improving the EU AI Act Toolkit.

This repository is practical, SME-friendly, source-aware, and not legal advice. See [DISCLAIMER.md](../docs/DISCLAIMER.md).

## Quick contribution paths

| I want to... | Start here |
|---|---|
| Fix typo or wording | Small documentation PR |
| Suggest a template | Template request issue |
| Add a sector example | SME use-case issue |
| Update source notes | Source update issue |
| Improve Pages site | Website/Docs PR |
| Report privacy/security concern | [SECURITY.md](SECURITY.md) |

<details>
<summary><strong>📋 Contribution principles</strong></summary>

- practical over academic
- plain English
- SME-friendly
- source-aware
- no legal overclaiming
- no confidential data
- use examples as fictional/sample only

</details>

<details>
<summary><strong>🚀 Good first contributions</strong></summary>

- improve template wording
- add a vendor question
- add a glossary term
- improve checklist usability
- add an SME use case
- fix a broken link

</details>

<details>
<summary><strong>🏷️ Issues and labels</strong></summary>

When GitHub labels are enabled on this repository, look for **`good first issue`** for small, well-scoped tasks. Maintainer triage uses standard labels such as `documentation`, `bug`, and `enhancement`; if you are unsure where a change belongs, open an issue first.

</details>

<details>
<summary><strong>🔄 Contribution workflow</strong></summary>

1. Open an issue if you are unsure.
2. Fork or create a branch.
3. Make a focused change.
4. Run the quality check.
5. Open a pull request.
6. Respond to review.

GitHub Actions also runs **Node.js** checks (`npm ci`, `npm run typecheck`, `npm test`) for the TypeScript quiz engine, **ShellCheck** on the quality/link/packaging shell scripts, **html-validate** on `docs/*.html` (see `.htmlvalidate.json`), **Lighthouse CI** on pushes to `main` that touch the site (`.github/workflows/lighthouse.yml`), and **Python** validation of `data/*.yml` against JSON Schema. To mirror that locally:

```bash
npx --yes html-validate@10.15.0 "docs/*.html"
./scripts/check-toolkit-quality.sh
cd .github/node-toolchain
npm ci
npm run typecheck
npm test
cd ../..
python3 -m pip install -r tools/requirements-ci.txt
python3 tools/validate_data_registries.py
```

If `PyYAML` and `jsonschema` are installed, `./scripts/check-toolkit-quality.sh` runs the data registry validation as part of the same script.

</details>

<details>
<summary><strong>📦 Dependencies and security (maintainer workflow)</strong></summary>

- **Main branch:** substantive and tooling changes are expected on **`main`** (see `.cursor/rules/eu-ai-act-toolkit-main-only.mdc`).
- **Dependabot:** `.github/dependabot.yml` sets **`open-pull-requests-limit: 0`**, so Dependabot does **not** open version-update PR branches. Bump **GitHub Actions**, **npm** in `.github/node-toolchain`, and **Docker** under `docker/` with ordinary commits on `main` (for example `npm outdated` in the toolchain directory and a refreshed `package-lock.json`).
- **Alerts:** enable **Dependabot alerts** (and optional security PRs) under the repository **Settings → Code security** if you want GitHub to flag known vulnerable dependencies; that is separate from the version-update limit above.
- **Forks:** workflows that publish the site image to GHCR use the repository owner for the registry namespace; fork maintainers should adjust image names or disable publishing if they do not use `ghcr.io`.

</details>

<details>
<summary><strong>📝 Content style guide</strong></summary>

See [docs/22-maintainer-content-style-guide.md](../docs/22-maintainer-content-style-guide.md).

**Mini checklist:**

- Avoid compliance-guarantee language
- Prefer `may require review`
- Link source notes when changing legal wording
- Add a disclaimer to sensitive examples

</details>

<details>
<summary><strong>✅ Pull request checklist</strong></summary>

- no legal overclaiming
- no confidential data
- source notes updated if needed
- quality check passes
- templates remain usable by SMEs

</details>

<details>
<summary><strong>🤝 Community resources</strong></summary>

| Resource | Purpose |
|---|---|
| [Code of Conduct](CODE_OF_CONDUCT.md) | Community standard |
| [Contributing Guide](CONTRIBUTING.md) | How to contribute |
| [Security Policy](SECURITY.md) | Security and privacy reporting |
| [Support](SUPPORT.md) | Where to ask for help |
| [Governance](../docs/project/governance.md) | How the project is maintained |
| [Maintainers](../docs/project/maintainers.md) | Maintainer information |
| [License Notes](../docs/project/license-notes.md) | Practical license explanation |

**Questions:**
- GitHub issues
- [SUPPORT.md](SUPPORT.md)
- GitHub Discussions, if enabled

**Contributor recognition:**
Contributors may appear in [CONTRIBUTORS.md](../docs/project/CONTRIBUTORS.md) and in the GitHub contributor graph when commits are properly attributed.

</details>
