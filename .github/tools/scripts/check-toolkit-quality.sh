#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
# shellcheck source=quality-lib.sh
source "$(dirname "${BASH_SOURCE[0]}")/quality-lib.sh"

old_readme_title="# 🇪🇺 EU AI Act Toolkit"" for SMEs"
old_maintainer_name="Artem ""Hobotun"

REQUIRED_FILES_LIST="$ROOT_DIR/tools/scripts/required-toolkit-files.txt"
check_file "tools/scripts/required-toolkit-files.txt"
while IFS= read -r file || [[ -n "${file:-}" ]]; do
  file="${file//$'\r'/}"
  [[ -z "${file// }" || "$file" =~ ^# ]] && continue
  check_file "$file"
done < "$REQUIRED_FILES_LIST"

if grep -qE '^[0-9]+\.[0-9]+\.[0-9]+$' "$ROOT_DIR/tools/dev/VERSION" 2>/dev/null; then
  pass "tools/dev/VERSION is a single-line semver (e.g. 1.5.0)"
else
  fail "tools/dev/VERSION must be a single semver line (major.minor.patch)"
fi

check_contains "README.md" "not legal advice"
check_contains "docs/DISCLAIMER.md" "not legal advice"
check_contains "README.md" "EU AI Act Toolkit"
check_contains "README.md" "Artem Nazarko"
check_contains "README.md" "Practical templates, checklists, and documentation tools for SMEs working toward EU AI Act readiness."
check_contains "README.md" "Organise your AI inventory"
check_contains "README.md" "Designed as a practical starting point for readiness, screening, and internal documentation"
check_contains "README.md" "This toolkit is educational and informational only. It is not legal advice and does not provide compliance assurance."
check_contains "README.md" "Selected Credentials"
check_contains "README.md" "Expand the sections below"
check_contains "README.md" "🗺️ Full toolkit map"
check_contains "README.md" "🧩 Templates and checklists"
check_contains "README.md" "🏢 Sector packs and examples"
check_contains "README.md" "🛡️ Trust, maintenance, and source notes"
check_contains "README.md" "🤝 Community, contribution, license, and security"
check_contains "README.md" "## 📦 Core toolkit packs"
check_contains "README.md" "Maintainer"
check_contains "README.md" "Vendor Assessment Pack"
check_contains "README.md" "docs/assets/branding/readme-hero-banner.png"
check_contains "README.md" "https://www.linkedin.com/in/artem-nazarko/"
check_contains "README.md" "https://orcid.org/0000-0002-4190-7288"
check_contains "README.md" "docs/assets/credentials/credly/ai-skills-passport.png"
check_contains "README.md" "docs/assets/credentials/credly/google-ai-professional-certificate.png"
check_contains "README.md" "docs/assets/credentials/credly/legal-ai-leader.png"
check_contains "README.md" "docs/assets/credentials/credly/ai-literacy.png"
check_contains "README.md" "docs/assets/credentials/credly/ai-fundamentals-with-ibm-skillsbuild.png"
check_contains "README.md" "docs/assets/credentials/credly/google-ai-essentials-v1.png"
check_contains "README.md" "<table width=\"100%\">"
check_contains "README.md" "width=\"118\""
check_contains "README.md" "width=\"16.66%\""
check_contains "README.md" "<nobr>Verify&nbsp;on&nbsp;Credly</nobr>"
check_contains "README.md" "Google&nbsp;/&nbsp;Coursera"
check_contains "README.md" "Microsoft&nbsp;Elevate"
check_contains "README.md" "Thomson&nbsp;Reuters"
check_contains "README.md" "IBM&nbsp;SkillsBuild"
check_contains "README.md" "[Artem Nazarko](https://github.com/artemhobotun)"
check_contains "README.md" "EU AI Act Toolkit"
check_contains "README.md" "legal professional, researcher, and legal-tech builder"
check_contains "README.md" "## 🌐 Live mini-site"
check_contains "README.md" "🚀 Open the EU AI Act Toolkit mini-site"
check_contains "README.md" "🧭 What is inside the mini-site?"
check_contains "README.md" "🐳 Container package / run locally"
check_contains "README.md" "ghcr.io/artemhobotun/eu-ai-act-toolkit-site"
check_contains "README.md" "docs/packages.md"
check_not_contains_file "README.md" "## 📦 Package"
check_contains "docs/packages.md" "ghcr.io/artemhobotun/eu-ai-act-toolkit-site"
check_contains "docs/packages.md" "docker run"
check_contains "docs/packages.md" "Forks and GHCR"
check_contains "tools/docker/Dockerfile" "nginxinc/nginx-unprivileged"
check_contains "tools/docker/Dockerfile" "COPY docs/"
check_contains ".github/workflows/publish-site-container.yml" "eu-ai-act-toolkit-site"
check_contains ".github/workflows/publish-site-container.yml" "ghcr.io"
check_contains ".github/workflows/publish-site-container.yml" "tools/docker/Dockerfile"
check_contains ".github/workflows/publish-site-container.yml" "aquasecurity/trivy-action@"
check_contains "README.md" "## 📊 Structured technical layer"
check_contains "README.md" "🧠 TypeScript quiz engine"
check_contains "README.md" "🗄 SQLite schema"
check_contains "README.md" "🧩 YAML registries"
check_contains "README.md" "✅ JSON Schemas"
check_contains "README.md" "## 🗂 Explore toolkit content"
check_contains "README.md" "🗺️ Full toolkit map"
check_contains "README.md" "🧩 Templates and checklists"
check_contains "README.md" "🏢 Sector packs and examples"
check_contains "README.md" "🛡️ Trust, maintenance, and source notes"
check_contains "README.md" "🤝 Community, contribution, license, and security"
check_not_contains_file "README.md" "^Community: "
check_contains "README.md" "## 🚀 Start here"
check_contains "README.md" "https://artemhobotun.github.io/EU-AI-Act-Toolkit/"
check_contains "README.md" "docs/guide/faq.md"
# Old lowercase URL should not appear (case-sensitive check needed)
if grep -F "https://artemhobotun.github.io/EU-AI-Act-toolkit/" README.md >/dev/null 2>&1; then
  fail "Old lowercase Pages URL found in README.md"
else
  pass "Old lowercase Pages URL absent in README.md"
fi
check_not_contains_file "README.md" "Click a badge to verify it on Credly."
check_not_contains_file "README.md" "Maintainer of the EU AI Act Toolkit. Focused on practical AI governance"
check_not_contains_file "README.md" "Open the mini-site: docs/index.html"
check_not_contains_file "README.md" "External credentials and professional profiles should be verified directly on the original platforms."
check_not_contains_file "README.md" "Website · Starter Pack · Vendor Pack · Credentials · Disclaimer · Quality checks"
check_not_contains_file "README.md" "$old_maintainer_name"
check_not_contains_file "README.md" "$old_readme_title"
check_contains "docs/guide/docs/guide/10-source-notes.md" "Regulation (EU) 2024/1689"
check_contains "toolkit/starter-pack/README.md" "not legal advice"
check_contains "toolkit/vendor-pack/README.md" "not legal advice"
check_contains "toolkit/vendor-pack/checklists/vendor-red-flags-checklist.md" "human oversight"
check_contains "toolkit/vendor-pack/templates/vendor-ai-due-diligence-questionnaire.md" "customer data"
check_contains "toolkit/vendor-pack/templates/vendor-decision-record.md" "Decision date"
check_contains "docs/index.html" "EU AI Act Toolkit"
check_contains "docs/index.html" "quiz.html"
check_contains "docs/packs.html" "Starter Pack"
check_contains "docs/packs.html" "official-sources.html"
check_contains "docs/packs.html" "quiz.html"
check_contains "docs/use-cases.html" "Use Cases"
check_contains "docs/use-cases.html" "official-sources.html"
check_contains "docs/use-cases.html" "quiz.html"
check_contains "docs/resources.html" "FAQ"
check_contains "docs/resources.html" "official-sources.html"
check_contains "docs/resources.html" "quiz.html"
check_contains "docs/maintainer.html" "Artem Nazarko"
check_contains "docs/maintainer.html" "Selected Professional Credentials"
check_contains "docs/maintainer.html" "Verify"
check_contains "docs/maintainer.html" "ai-skills-passport.png"
check_contains "docs/maintainer.html" "google-ai-professional-certificate.png"
check_contains "docs/maintainer.html" "legal-ai-leader.png"
check_contains "docs/maintainer.html" "ai-literacy.png"
check_contains "docs/maintainer.html" "ai-fundamentals-with-ibm-skillsbuild.png"
check_contains "docs/maintainer.html" "google-ai-essentials-v1.png"
check_contains "docs/maintainer.html" "Credly"
check_contains "docs/maintainer.html" "quiz.html"
check_contains "docs/community.html" "official-sources.html"
check_contains "docs/community.html" "quiz.html"
check_contains "docs/quiz.html" "EU AI Act"
check_contains "docs/quiz.html" "Self-Check"
check_contains "docs/quiz.html" "official-sources.html"
check_contains "docs/official-sources.html" "eur-lex.europa.eu/eli/reg/2024/1689/oj"
check_contains "docs/official-sources.html" "digital-strategy.ec.europa.eu/en/policies/regulatory-framework-ai"
check_contains "docs/official-sources.html" "digital-strategy.ec.europa.eu/en/policies/ai-office"
check_contains "docs/official-sources.html" "quiz.html"
check_contains ".github/CONTRIBUTING.md" "Code of Conduct"
check_contains ".github/CONTRIBUTING.md" "[Code of Conduct](CODE_OF_CONDUCT.md)"
check_contains ".github/CONTRIBUTING.md" "[Security Policy](SECURITY.md) | Security and privacy reporting"
check_contains ".github/CONTRIBUTING.md" "[Support](SUPPORT.md) | Where to ask for help"
check_contains ".github/CONTRIBUTING.md" "[Governance](../.github/project/governance.md) | How the project is maintained"
check_contains ".github/CONTRIBUTING.md" "[Maintainers](../.github/project/maintainers.md) | Maintainer information"
check_contains ".github/project/credentials.md" "Credly"
check_contains ".github/project/credentials.md" "Artem Nazarko"
check_contains ".github/project/credentials.md" "../assets/credentials/credly/ai-skills-passport.png"
check_contains ".github/CODE_OF_CONDUCT.md" "confidential"
check_contains ".github/CONTRIBUTING.md" "quality check"
check_contains ".github/SECURITY.md" "personal data"
check_contains ".github/SUPPORT.md" "not legal advice"
check_contains ".github/project/governance.md" "legal overclaiming"
check_contains ".github/project/maintainers.md" "Artem Nazarko"
check_contains ".github/project/license-notes.md" "no warranty"
check_contains ".github/project/roadmap.md" "v0.4 Vendor assessment pack"
check_contains ".github/project/README.md" "Project Files"
check_contains ".github/PULL_REQUEST_TEMPLATE.md" "No claim that this guarantees compliance"
check_not_contains_file "README.md" "camo.githubusercontent.com"
check_not_contains_file "README.md" "shields.io"
check_not_contains_file "README.md" "404 badge not found"
check_not_contains_file "README.md" "docs/assets/credentials/cards/"

# Check for root-relative internal page links in GitHub Pages HTML files
check_not_contains_file "docs/index.html" "href=\"/\""
check_not_contains_file "docs/index.html" "href=\"/packs.html\""
check_not_contains_file "docs/index.html" "href=\"/use-cases.html\""
check_not_contains_file "docs/index.html" "href=\"/resources.html\""
check_not_contains_file "docs/index.html" "href=\"/maintainer.html\""
check_not_contains_file "docs/index.html" "href=\"/community.html\""
check_not_contains_file "docs/packs.html" "href=\"/\""
check_not_contains_file "docs/packs.html" "href=\"/packs.html\""
check_not_contains_file "docs/packs.html" "href=\"/use-cases.html\""
check_not_contains_file "docs/packs.html" "href=\"/resources.html\""
check_not_contains_file "docs/packs.html" "href=\"/maintainer.html\""
check_not_contains_file "docs/packs.html" "href=\"/community.html\""
check_not_contains_file "docs/use-cases.html" "href=\"/\""
check_not_contains_file "docs/use-cases.html" "href=\"/packs.html\""
check_not_contains_file "docs/use-cases.html" "href=\"/use-cases.html\""
check_not_contains_file "docs/use-cases.html" "href=\"/resources.html\""
check_not_contains_file "docs/use-cases.html" "href=\"/maintainer.html\""
check_not_contains_file "docs/use-cases.html" "href=\"/community.html\""
check_not_contains_file "docs/resources.html" "href=\"/\""
check_not_contains_file "docs/resources.html" "href=\"/packs.html\""
check_not_contains_file "docs/resources.html" "href=\"/use-cases.html\""
check_not_contains_file "docs/resources.html" "href=\"/resources.html\""
check_not_contains_file "docs/resources.html" "href=\"/maintainer.html\""
check_not_contains_file "docs/resources.html" "href=\"/community.html\""
check_not_contains_file "docs/maintainer.html" "href=\"/\""
check_not_contains_file "docs/maintainer.html" "href=\"/packs.html\""
check_not_contains_file "docs/maintainer.html" "href=\"/use-cases.html\""
check_not_contains_file "docs/maintainer.html" "href=\"/resources.html\""
check_not_contains_file "docs/maintainer.html" "href=\"/maintainer.html\""
check_not_contains_file "docs/maintainer.html" "href=\"/community.html\""
check_not_contains_file "docs/community.html" "href=\"/\""
check_not_contains_file "docs/community.html" "href=\"/packs.html\""
check_not_contains_file "docs/community.html" "href=\"/use-cases.html\""
check_not_contains_file "docs/community.html" "href=\"/resources.html\""
check_not_contains_file "docs/community.html" "href=\"/maintainer.html\""
check_not_contains_file "docs/community.html" "href=\"/community.html\""
check_not_contains_file "docs/quiz.html" "href=\"/\""
check_not_contains_file "docs/quiz.html" "href=\"/packs.html\""
check_not_contains_file "docs/quiz.html" "href=\"/use-cases.html\""
check_not_contains_file "docs/quiz.html" "href=\"/resources.html\""
check_not_contains_file "docs/quiz.html" "href=\"/maintainer.html\""
check_not_contains_file "docs/quiz.html" "href=\"/community.html\""
check_not_contains_file "docs/official-sources.html" "href=\"/\""
check_not_contains_file "docs/official-sources.html" "href=\"/packs.html\""
check_not_contains_file "docs/official-sources.html" "href=\"/use-cases.html\""
check_not_contains_file "docs/official-sources.html" "href=\"/resources.html\""
check_not_contains_file "docs/official-sources.html" "href=\"/maintainer.html\""
check_not_contains_file "docs/official-sources.html" "href=\"/community.html\""

# Check for root-relative asset links
check_not_contains_file "docs/index.html" "href=\"/assets/"
check_not_contains_file "docs/index.html" "src=\"/assets/"
check_not_contains_file "docs/packs.html" "href=\"/assets/"
check_not_contains_file "docs/packs.html" "src=\"/assets/"
check_not_contains_file "docs/use-cases.html" "href=\"/assets/"
check_not_contains_file "docs/use-cases.html" "src=\"/assets/"
check_not_contains_file "docs/resources.html" "href=\"/assets/"
check_not_contains_file "docs/resources.html" "src=\"/assets/"
check_not_contains_file "docs/maintainer.html" "href=\"/assets/"
check_not_contains_file "docs/maintainer.html" "src=\"/assets/"
check_not_contains_file "docs/community.html" "href=\"/assets/"
check_not_contains_file "docs/community.html" "src=\"/assets/"
check_not_contains_file "docs/quiz.html" "href=\"/assets/"
check_not_contains_file "docs/quiz.html" "src=\"/assets/"
check_not_contains_file "docs/official-sources.html" "href=\"/assets/"
check_not_contains_file "docs/official-sources.html" "src=\"/assets/"

check_not_contains_repo "certified compliant"
check_not_contains_repo "fully compliant"
check_not_contains_repo "guaranteed compliant"

# Verify policy files have details blocks for improved readability
check_contains ".github/CODE_OF_CONDUCT.md" "<details>"
check_contains ".github/CODE_OF_CONDUCT.md" "Quick standard"
check_contains ".github/CODE_OF_CONDUCT.md" "Expected behaviour"
check_contains ".github/CODE_OF_CONDUCT.md" "Unacceptable behaviour"
check_contains ".github/CODE_OF_CONDUCT.md" "Legal and compliance wording"
check_contains ".github/CODE_OF_CONDUCT.md" "Reporting concerns"
check_contains ".github/CODE_OF_CONDUCT.md" "Enforcement and scope"
check_contains ".github/CONTRIBUTING.md" "<details>"
check_contains ".github/CONTRIBUTING.md" "Quick contribution paths"
check_contains ".github/CONTRIBUTING.md" "Contribution principles"
check_contains ".github/CONTRIBUTING.md" "Good first contributions"
check_contains ".github/CONTRIBUTING.md" "Issues and labels"
check_contains ".github/CONTRIBUTING.md" "good first issue"
check_contains ".github/CONTRIBUTING.md" "Contribution workflow"
check_contains ".github/CONTRIBUTING.md" "Content style guide"
check_contains ".github/CONTRIBUTING.md" "Pull request checklist"
check_contains ".github/CONTRIBUTING.md" "Community resources"
check_contains ".github/SECURITY.md" "<details>"
check_contains ".github/SECURITY.md" "Quick rules"
check_contains ".github/SECURITY.md" "What this repository is"
check_contains ".github/SECURITY.md" "What this repository is not"
check_contains ".github/SECURITY.md" "Supported versions"
check_contains ".github/SECURITY.md" "Reporting guidance"
check_contains ".github/SECURITY.md" "What not to put in issues"
check_contains ".github/SECURITY.md" "Template safety"
check_contains ".github/SECURITY.md" "GitHub Pages note"

# Verify compact root structure
if [[ ! -d "$ROOT_DIR/checklists" ]]; then
  pass "No stray checklists/ at root (moved to toolkit/)"
else
  fail "Stray checklists/ directory at root (should be in toolkit/)"
fi

if [[ ! -d "$ROOT_DIR/templates" ]]; then
  pass "No stray templates/ at root (moved to toolkit/)"
else
  fail "Stray templates/ directory at root (should be in toolkit/)"
fi

if [[ ! -d "$ROOT_DIR/examples" ]]; then
  pass "No stray examples/ at root (moved to toolkit/)"
else
  fail "Stray examples/ directory at root (should be in toolkit/)"
fi

if [[ ! -d "$ROOT_DIR/sector-packs" ]]; then
  pass "No stray sector-packs/ at root (moved to toolkit/)"
else
  fail "Stray sector-packs/ directory at root (should be in toolkit/)"
fi

if [[ ! -d "$ROOT_DIR/starter-pack" ]]; then
  pass "No stray starter-pack/ at root (moved to toolkit/)"
else
  fail "Stray starter-pack/ directory at root (should be in toolkit/)"
fi

if [[ ! -d "$ROOT_DIR/vendor-pack" ]]; then
  pass "No stray vendor-pack/ at root (moved to toolkit/)"
else
  fail "Stray vendor-pack/ directory at root (should be in toolkit/)"
fi

check_hygiene_pattern '* 2.md'
check_hygiene_pattern '.DS_Store'

if git -C "$ROOT_DIR" ls-files --error-unmatch 'dist/*.zip' >/dev/null 2>&1; then
  fail "Found committed ZIP file under dist/"
else
  pass "No committed ZIP files under dist/"
fi

if [[ -f "$ROOT_DIR/tools/scripts/check-common-links.sh" ]]; then
  pass "Link audit script present"
else
  fail "Link audit script missing"
fi

if [[ -x "$ROOT_DIR/tools/scripts/check-common-links.sh" ]]; then
  pass "Link audit script is executable"
else
  fail "Link audit script is not executable"
fi

# Structured data layer validation (added in v1.5.0)
# TypeScript quiz engine
if grep -q "export enum ReadinessLevel" "$ROOT_DIR/tools/quiz-engine/quiz-engine.ts"; then
  pass "TypeScript export types found in tools/quiz-engine/quiz-engine.ts"
else
  fail "TypeScript export types missing in tools/quiz-engine/quiz-engine.ts"
fi

if grep -q "calculateReadinessScore" "$ROOT_DIR/tools/quiz-engine/quiz-engine.ts"; then
  pass "Quiz scoring function found in tools/quiz-engine/quiz-engine.ts"
else
  fail "Quiz scoring function missing in tools/quiz-engine/quiz-engine.ts"
fi

# SQL evidence schema
if grep -q "CREATE TABLE.*ai_systems" "$ROOT_DIR/.github/project/database/evidence-pack-schema.sql"; then
  pass "AI systems table found in evidence-pack-schema.sql"
else
  fail "AI systems table missing in evidence-pack-schema.sql"
fi

# YAML registries validation (check for expected keys without requiring PyYAML)
if grep -q "^  - id:" "$ROOT_DIR/tools/data/toolkit-registry.yml"; then
  pass "toolkit-registry.yml has expected structure (id: entries)"
else
  fail "toolkit-registry.yml missing expected structure"
fi

if grep -q "^  - id:" "$ROOT_DIR/tools/data/official-sources.yml"; then
  pass "official-sources.yml has expected structure (id: entries)"
else
  fail "official-sources.yml missing expected structure"
fi

if grep -q "^  - id:" "$ROOT_DIR/tools/data/use-cases.yml"; then
  pass "use-cases.yml has expected structure (id: entries)"
else
  fail "use-cases.yml missing expected structure"
fi

# JSON Schema and sample files (parse as JSON)
if command -v python3 &> /dev/null; then
  if python3 "$ROOT_DIR/tools/tools/check_json_files_parse.py"; then
    pass "Schema and sample JSON files parse as valid JSON"
  else
    fail "One or more schema/sample JSON files failed JSON parse"
  fi
fi

# Quality tooling checks (added in v1.4.0)
if [[ -f "$ROOT_DIR/.gitattributes" ]]; then
  pass ".gitattributes present for Linguist configuration"
else
  fail ".gitattributes missing"
fi

if [[ -f "$ROOT_DIR/docs/assets/site.js" ]]; then
  pass "Site interactivity script present: docs/assets/site.js"
else
  fail "Site interactivity script missing: docs/assets/site.js"
fi

if [[ -f "$ROOT_DIR/tools/tools/validate_site_links.py" ]]; then
  pass "Link validation tool present: tools/tools/validate_site_links.py"
else
  fail "Link validation tool missing: tools/tools/validate_site_links.py"
fi

if [[ -f "$ROOT_DIR/tools/tools/build_toolkit_manifest.py" ]]; then
  pass "Toolkit manifest builder present: tools/tools/build_toolkit_manifest.py"
else
  fail "Toolkit manifest builder missing: tools/tools/build_toolkit_manifest.py"
fi

# Run Python quality tools if available
if command -v python3 &> /dev/null; then
  if python3 "$ROOT_DIR/tools/tools/validate_site_links.py"; then
    pass "Site link validation passed"
  else
    fail "Site link validation failed"
  fi

  if python3 "$ROOT_DIR/tools/tools/verify_toolkit_manifest_sync.py"; then
    pass "Toolkit manifest matches build_toolkit_manifest.py (generated timestamp ignored)"
  else
    fail "Toolkit manifest out of sync; run: python3 tools/tools/build_toolkit_manifest.py && git add docs/assets/toolkit-manifest.json"
  fi
else
  pass "Python3 not available (link validation and manifest generation skipped)"
fi

# Data registry YAML vs JSON Schema (optional locally if PyYAML + jsonschema installed)
if command -v python3 &> /dev/null; then
  if python3 -c "import yaml, jsonschema" 2>/dev/null; then
    if python3 "$ROOT_DIR/tools/tools/validate_data_registries.py"; then
      pass "Data registries validated against document JSON Schemas"
    else
      fail "Data registry validation failed"
    fi
  else
    pass "PyYAML/jsonschema not installed (install tools/tools/requirements-ci.txt to validate data registries locally)"
  fi

  if python3 -c "import jsonschema" 2>/dev/null; then
    if python3 "$ROOT_DIR/tools/tools/validate_schema_samples.py"; then
      pass "JSON Schema samples validated against instance schemas"
    else
      fail "JSON Schema sample validation failed"
    fi
  else
    pass "jsonschema not installed (schema sample validation skipped locally)"
  fi
fi

if [[ "$FAILURES" -gt 0 ]]; then
  printf 'Quality checks failed: %s\n' "$FAILURES"
  exit 1
fi

printf 'Quality checks passed.\n'
