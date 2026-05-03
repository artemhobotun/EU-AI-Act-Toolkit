# ✨ Contributing to the EU AI Act Toolkit

Thanks for improving the EU AI Act Toolkit.

This repository is practical, SME-friendly, source-aware, and not legal advice. See [DISCLAIMER.md](../DISCLAIMER.md).

## Quick contribution paths

| I want to... | Start here |
|---|---|
| Fix typo or wording | Small documentation PR |
| Suggest a template | Template request issue |
| Add a sector example | SME use-case issue |
| Update source notes | Source update issue |
| Improve Pages site | Website/Docs PR |
| Report privacy/security concern | [SECURITY.md](../SECURITY.md) |

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
<summary><strong>🔄 Contribution workflow</strong></summary>

1. Open an issue if you are unsure.
2. Fork or create a branch.
3. Make a focused change.
4. Run the quality check.
5. Open a pull request.
6. Respond to review.

```bash
./scripts/check-toolkit-quality.sh
```

GitHub Actions also runs **Node.js** checks (`npm ci`, `npm run typecheck`, `npm test`) for the TypeScript quiz engine, and **Python** validation of `data/*.yml` against JSON Schema. To mirror that locally:

```bash
cd dev/typescript-toolchain
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
| [Security Policy](../SECURITY.md) | Security and privacy reporting |
| [Support](SUPPORT.md) | Where to ask for help |
| [Governance](../docs/project/governance.md) | How the project is maintained |
| [Maintainers](../docs/project/maintainers.md) | Maintainer information |
| [License Notes](../docs/project/license-notes.md) | Practical license explanation |

**Questions:**
- GitHub issues
- [SUPPORT.md](SUPPORT.md)
- GitHub Discussions, if enabled

**Contributor recognition:**
Contributors may appear in [CONTRIBUTORS.md](../CONTRIBUTORS.md) and in the GitHub contributor graph when commits are properly attributed.

</details>
