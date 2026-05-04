# Maintenance and Review Process

This toolkit should be maintained as a living project. The EU AI Act is implemented over time and supported by guidance, standards, and enforcement practice that may evolve.

This document describes a practical maintenance process for keeping the toolkit useful and conservative.

## Principles

- Prefer practical SME-facing language over legal or academic wording.
- Avoid statements that imply a guarantee of compliance.
- Keep source notes conservative: cite the legal basis and point readers to official sources for updates.
- Keep templates generic and adaptable to different sectors and roles (provider/deployer).

## Review Cadence (Recommended)

- Monthly (lightweight):
  - scan for major updates from official EU sources
  - review open issues/PRs and resolve easy improvements
- Quarterly (deeper):
  - review core templates and checklists
  - verify that the "Source Notes" remain accurate and non-committal
  - run a quick pass on links for breakage
- After major updates (as needed):
  - update templates and guidance after significant legal/guidance changes
  - record changes in the changelog

## What to Monitor

1. Official EU sources:
   - European Commission and the EU AI Office updates
2. Implementation guidance:
   - new guidance documents, Q&A, and official clarifications
3. Harmonised standards and related materials:
   - when standards are published or updated, review relevant sections and adjust templates

## How to Update the Toolkit

1. Start with the "Source Notes" and identify what changed:
   - docs/10-source-notes.md
2. Update templates and checklists to remain usable for SMEs:
   - keep fields stable where possible to avoid churn for users
3. Keep language conservative:
   - prefer "readiness", "screening", "starting point", "documentation support"
   - avoid "compliant" unless it is clearly qualified and contextual
4. Add a changelog entry for notable updates:
   - [CHANGELOG.md](project/CHANGELOG.md)

## Change Management

- Use issues for requests and suggestions.
- Use PRs for all content changes (docs/templates/checklists).
- In PR descriptions, explain:
  - what changed
  - why it matters for SMEs
  - any limitations or assumptions

## Quality Checks Before Merging

- No claims that templates provide compliance assurance.
- No unsupported legal claims or definitive classifications when the correct approach is "check official guidance" and assess the actual system and role.
- Links to sources are official where possible (avoid marketing pages).
- Templates remain generic (no real personal data, no real incident data).
