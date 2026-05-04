# Changelog

All notable changes to this project will be documented in this file.

The project follows a lightweight approach to versioning while the toolkit stabilizes.

## Unreleased

### CI, quality scripts, and repository hygiene

- Pinned third-party GitHub Actions to full commit SHAs (checkout, setup-node, setup-python, docker/login, docker/build-push, trivy-action) for reproducible CI.
- **Dockerfile:** switched base image to **`nginxinc/nginx-unprivileged`** (non-root, container port **8080**) so Trivy config scan passes **DS-0002**; README and `docs/packages.md` use **`docker run -p 8080:8080`**.
- **Lighthouse CI:** use **`@lhci/cli@0.15.1`** (0.14.1 is not published on npm).
- **Publish site container:** Trivy config scan on `./docker` now uses **`exit-code: "1"`** so misconfigurations at CRITICAL/HIGH severity fail the workflow.
- Added **`html-validate`** job (recommended rules; inline `style` allowed) and **`lighthouserc.js`** + **`lighthouse.yml`** workflow for static runs against `docs/`.
- Added **`tools/check_json_files_parse.py`** and **`scripts/required-toolkit-files.txt`** so required-file lists and JSON parse checks are easier to maintain.
- Added root **`AGENTS.md`**, **`engines.node`** in `.github/node-toolchain/package.json`, **SECURITY** row on Dependabot alerts, and **docs/packages.md** fork/GHCR note.
- Refactored **`scripts/check-common-links.sh`** to source **`quality-lib.sh`**. Fixed bare **`&`** in several **`docs/*.html`** headings and **`type="button"`** on quiz navigation buttons for standards-compliant markup.

- Added `tools/verify_toolkit_manifest_sync.py`: CI compares the committed `docs/assets/toolkit-manifest.json` to `build_toolkit_manifest.py` output with **`generated` ignored**, so the manifest does not need rewriting every run.
- Split shared bash helpers into `scripts/quality-lib.sh` sourced by `check-toolkit-quality.sh`.
- Added a **ShellCheck** job (`shellcheck -S error scripts/*.sh`) to Toolkit quality checks.
- Added **concurrency** groups to cancel superseded workflow runs for quality checks and site container publish.
- **Publish site container:** image tags include `VERSION` from the repo root, registry path uses lowercase `github.repository_owner`, and push triggers on `VERSION` changes (see bullets above for Trivy).
- Removed hundreds of committed `toolkit/examples/progress-notes/**/toolkit-progress-note-*.md` samples; added `README.md`, `EXAMPLE_PROGRESS_NOTE.md`, and `.gitignore` for local-only note filenames; Linguist override for that folder.
- Documented maintainer dependency workflow (main-only bumps, Dependabot limit 0, security alerts, forks) in `.github/CONTRIBUTING.md`.

### Tooling, site parity, and repository polish

- Renamed README hero image asset to `docs/assets/branding/readme-hero-banner.png` (replacing `test.png`).
- Added root `VERSION` file; `tools/build_toolkit_manifest.py` now reads the toolkit version from it (ISO-8601 manifest timestamps use UTC).
- Aligned `docs/assets/site.js` quiz tier boundaries with `src/quiz-engine.ts` (inclusive 33% / 66% thresholds).
- Added Vitest guard `src/site-quiz-parity.test.ts` to prevent the Pages quiz from drifting from the TypeScript engine.
- Added minimal JSON samples under `schemas/samples/` and `tools/validate_schema_samples.py` (CI + quality script).
- Removed duplicate `docs/community.html` entry from the quality script required-file list.
- Added `.editorconfig` and Dependabot updates for the `docker/` image.
- Documented issue labels and `good first issue` in `.github/CONTRIBUTING.md`; README community section links to the changelog.

### README Restructuring — Mini-site, Technical Sections, and Navigation

- Reordered the README mini-site section so the mini-site overview appears before the main CTA.
- Improved the visibility of the live mini-site CTA with enhanced styling.
- Refactored the structured technical layer to remove duplicated visible lists.
- Split repository navigation into a dedicated "Explore toolkit content" section.
- Removed inline community-link clutter from the README.
- Updated quality check script to validate new README structure.

### README Restructuring — Mini-site and Package Sections

- Simplified the README live mini-site section into a cleaner call-to-action block.
- Moved the mini-site page structure into a collapsible details section.
- Moved package/container usage information into the structured technical layer as a hidden details block.
- Reduced visible README clutter while keeping package documentation available.
- Updated quality check script to validate new README structure.

### v1.5.0 — Structured Toolkit Data Layer

- Added TypeScript quiz scoring engine (src/quiz-engine.ts) with fully typed readiness assessment logic, 10 example questions, and three readiness levels.
- Added SQLite schema (database/evidence-pack-schema.sql) for optional local evidence pack storage with 8 tables: ai_systems, risk_screenings, vendors, vendor_reviews, incidents, ai_literacy_records, maintenance_reviews, source_updates.
- Added YAML machine-readable registries (data/):
  - toolkit-registry.yml: 13 toolkit resources with metadata for discoverability.
  - official-sources.yml: 6 official EU AI Act sources with institution, publication date, and use cases.
  - use-cases.yml: 7 common AI governance scenarios with key concerns and escalation triggers.
- Added JSON Schema definitions (schemas/):
  - ai-system-inventory.schema.json: Validates AI system inventory data.
  - risk-screening.schema.json: Validates readiness screening results.
  - vendor-review.schema.json: Validates vendor assessment documentation.
- Added comprehensive README files for schemas/ and database/ explaining structure, use cases, and integration patterns.
- Updated quality check script to require and validate all new structured data files with lightweight checks.
- Updated .gitattributes to mark src/**, database/**, data/**, schemas/** as project source (not documentation).
- Updated README with compact "Structured technical layer" section linking to new registries and schemas.
- Updated docs/resources.html with "Structured Toolkit Data" section featuring cards for each layer with links to technical resources.
- All structured data files are informational, optional, and designed for tool integration without being required for toolkit use.

### v1.4.0 — Site Interactivity and Quality Tooling

- Added GitHub Linguist configuration (.gitattributes) to properly count HTML, CSS, and JavaScript as project source code.
- Added lightweight JavaScript (docs/assets/site.js) for Pages interactivity: quiz scoring, result recommendations, scroll animations, active nav state, and copy-link buttons.
- Integrated site.js across all eight GitHub Pages HTML files (index, packs, use-cases, resources, quiz, official-sources, maintainer, community).
- Added Python tool (tools/validate_site_links.py) to validate local file references in static site HTML.
- Added Python tool (tools/build_toolkit_manifest.py) to generate toolkit metadata manifest (docs/assets/toolkit-manifest.json).
- Updated quality check script (scripts/check-toolkit-quality.sh) to call Python validation tools and verify new files.
- Marked generated assets (dist/**, toolkit-manifest.json) as linguist-generated in .gitattributes.
- All JavaScript and Python tooling is purely defensive, non-breaking, and produces meaningful project contributions.

### v1.3.0 — Site Container Package

- Added a GitHub Packages container workflow for the static Pages site.
- Added Dockerfile (nginx:alpine serving docs/) for the `ghcr.io/artemhobotun/eu-ai-act-toolkit-site` image.
- Added `.github/workflows/publish-site-container.yml` — builds and pushes on main changes to Dockerfile or docs/.
- Added `docs/packages.md` with package documentation and local run instructions.
- Updated README with compact Package section and `docker run` command.
- Updated quality checks to verify Dockerfile, .dockerignore, workflow, and package docs presence.

### v1.2.0 — Premium Pages Redesign with Quiz and Official Source Layer

- Full second-generation redesign of all GitHub Pages pages using a premium v3.0 design system.
- Added interactive AI governance self-check quiz (docs/quiz.html) with 10 guided questions, weighted scoring, and three result tiers.
- Added dedicated official EU AI Act sources page (docs/official-sources.html) with links to EUR-Lex, European Commission, and EU AI Office.
- Redesigned docs/index.html as a flagship portal page with stronger hero, stats row, guided paths, and quiz CTA.
- Upgraded docs/packs.html with premium card layout, sector pack attention badges, and consistent design system.
- Upgraded docs/use-cases.html with scenario cards including category and attention-level badges.
- Upgraded docs/resources.html with FAQ accordion, learning path steps, and official sources teaser.
- Upgraded docs/maintainer.html with premium profile hero, "Why I built this" narrative, and refined credentials grid.
- Upgraded docs/community.html with resource-row layout, cleaner governance section, and consistent design.
- Applied consistent sticky nav with EU Sources and Self-Check links across all eight pages.
- Applied consistent premium footer (footer-top, footer-brand) across all pages.
- Established deep navy / midnight base with EU-blue and gold accents as design system tokens.
- Added subtle background grid, card hover lift, progress bar, and badge components to design system.
- Added quiz progress indicator, animated question transitions, and polished result panel.
- Updated quality checks to verify quiz.html and official-sources.html presence, content, and relative link correctness.
- Updated CHANGELOG with full v1.2.0 entry.

- Fixed GitHub Pages project-site navigation by replacing root-relative internal links with relative links.
- Added quality checks to prevent broken project-site links on GitHub Pages.
- Redesigned the GitHub Pages mini-site into a multi-page static toolkit portal.
- Added separate Pages sections for Toolkit Packs, Use Cases, Resources, Maintainer, and Community.
- Improved navigation, layout, card system, and overall visual polish.
- Created shared design system with consistent typography, spacing, colors, and responsive layout.
- Reorganized mini-site content for better clarity and professional presentation.
- Restructured community policy files for improved readability with quick reference tables and collapsible details blocks.
- Updated CODE_OF_CONDUCT.md with Quick standard table and 5 collapsible sections.
- Updated CONTRIBUTING.md with Quick contribution paths table and 6 collapsible sections.
- Updated SECURITY.md with Quick rules table and 7 collapsible sections.
- Enhanced quality checks to verify presence of details blocks in policy files.
- Expanded and balanced the Selected Credentials table layout.
- Increased Credly badge image size while keeping all six badges in one row.
- Prevented issuer and verification labels from wrapping.
- Shortened the Selected Credentials intro sentence.
- Replaced the maintainer note with a fuller professional author note and links.
- Kept all six Credly badges in a single compact row.
- Prevented credential issuer and verification labels from wrapping using non-breaking spaces.
- Moved the live interactive mini-site section above Start here.
- Updated Start here heading with emoji and removed duplicate mini-site link from that section.
- Refreshed the README / Pages hero image using the updated `test.png` asset.
- Moved practical toolkit content into a unified `toolkit/` folder.
- Moved checklists, templates, starter pack, vendor pack, sector packs, and examples under `toolkit/`.
- Updated README, GitHub Pages, scripts, and quality checks for the new compact root structure.
- Added `toolkit/README.md` as an index for practical working materials.
- Kept LICENSE, CITATION.cff, README, DISCLAIMER, SECURITY, .github, docs, scripts, and toolkit in the repository root.
- Simplified the README top section by removing the post-hero navigation link row.
- Reworked the opening README text into a clearer, more polished introduction.
- Switched the README hero to use the refreshed `test.png` image.
- Restored the Google AI Essentials Credly badge to the Selected Credentials display.
- Adjusted Selected Credentials to show six badges in a single compact row.
- Fixed the Community resources table in the contributing guide.
- Prepared repository links for the `EU-AI-Act-Toolkit` repository name.
- Kept the Maintainer section immediately below the opening/disclaimer block.
- Added emoji labeling and helper text for collapsible README sections.
- Updated the Core toolkit packs heading with icon treatment.
- Fixed the Credly profile button icon color to use the requested dark green accent.
- Switched the README hero to a flattened PNG version for reliable GitHub rendering.
- Added two new Credly badges to the selected credentials section.
- Simplified the maintainer section by removing the external-verification sentence from README.
- Compact the repository root by moving community health files into `.github/` and project meta files into `docs/project/`.
- Added a `docs/project/` index to keep the relocated documentation easy to find.
- Updated maintainer name to Artem Nazarko while keeping @artemhobotun as GitHub username.
- Improved the live mini-site section to make the GitHub Pages entry point clearer.
- Reworked profile buttons into compact, colorful GitHub, LinkedIn, Credly, and ORCID buttons.
- Fixed Credly badge rendering in README by using direct PNG badge images.
- Simplified Selected Credentials captions.
- Updated GitHub Pages credentials section to show real badge images.
- Updated quality checks for maintainer name and credential image rendering.
- Renamed visible project title to “EU AI Act Toolkit” while keeping SME focus in the description.
- Reorganized README into a cleaner landing-page structure.
- Moved large sections into collapsible details blocks.
- Moved community resource table out of the main README body.
- Improved maintainer section placement and profile links.
- Added more colorful profile icon buttons for GitHub, LinkedIn, Credly, and ORCID.
- Normalized Credly credential cards and simplified badge captions.
- Updated GitHub Pages to match the cleaner branding and credentials layout.
- Expanded quality checks for branding and credential assets.
- Redesigned the README hero banner with an EU-inspired star motif.
- Removed cluttered shields badge row from the README.
- Added selected Credly credentials gallery with clickable badge verification links.
- Added maintainer profile links for GitHub, LinkedIn, Credly, and ORCID.
- Updated GitHub Pages with maintainer and credentials sections.
- Expanded quality checks for credential assets and README badge hygiene.
- Added Vendor Assessment Pack.
- Added AI vendor due diligence questionnaire.
- Added vendor comparison matrix and vendor risk register.
- Added vendor red flags, procurement workflow, meeting checklist, and approval checklist.
- Added vendor email templates.
- Added fictional vendor review examples.
- Added vendor decision records.
- Updated README, starter pack, templates/checklists indexes, GitHub Pages, and quality checks.
- Polished community health files: Code of Conduct, Contributing, Security, Support, Governance, Maintainers, and License Notes.
- Added structured GitHub issue forms.
- Improved pull request template.
- Added GitHub Pages community page.
- Updated README community navigation.
- Expanded quality checks for community files.
- Added SME Starter Pack.
- Added 30-minute readiness self-assessment.
- Added one-page executive checklist.
- Added printable starter templates.
- Added internal rollout materials.
- Added management briefing and quarterly review templates.
- Added local ZIP build script.
- Updated README and GitHub Pages with starter pack navigation.
- Expanded quality checks for starter pack files.
- Added sector packs for common SME AI use cases.
- Added SME decision tree, glossary, implementation playbook, and common mistakes guide.
- Added fictional sample evidence pack.
- Added template, checklist, and examples indexes.
- Improved GitHub Pages interactive readiness experience.
- Updated quality checks for new content.
- Added toolkit quality check script and GitHub Actions workflow.
- Added official source register.
- Added versioning and maintenance policy.
- Added escalation guide for legal review.
- Added evidence pack index CSV and maintenance review log.
- Added downloadable toolkit pack guide.
- Updated README with quality, trust, and evidence pack sections.
- Updated GitHub Pages mini-site with trust and maintenance resources.
- Added maintenance and review process documentation.
- Added Lucius Domitius Ahenobarbus as a contributor.
- Polished public README presentation.
- Added GitHub Pages mini-site.
- Added maintainer credentials page.
- Added social preview asset.
- Added roadmap, security policy, citation metadata, PR template, and issue templates.
- Added SME use-case examples.
- Added 4-week small-company implementation guide.
- Added evidence pack index.
- Improved README project status and start-here sections.
- Improved GitHub Pages mini-site with use-case examples and implementation path.

## 0.1.0 - 2026-05-02

- Converted repository into the **EU AI Act SME Toolkit**.
- Added practical docs, checklists, and templates for AI inventory, screening, procurement, literacy, and internal governance.
