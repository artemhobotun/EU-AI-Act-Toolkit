#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
# shellcheck source=quality-lib.sh
source "$(dirname "${BASH_SOURCE[0]}")/quality-lib.sh"

# Core files
echo "=== Checking core project files ==="
check_file "README.md"
check_file "docs/DISCLAIMER.md"
check_file ".github/SECURITY.md"
check_file "LICENSE"

# HTML pages
echo "=== Checking GitHub Pages files ==="
check_file "docs/index.html"
check_file "docs/community.html"

# Toolkit structure
echo "=== Checking toolkit structure ==="
if [[ -d "$ROOT_DIR/toolkit" ]]; then
  pass "toolkit/ directory"
else
  fail "toolkit/ directory missing"
fi
check_file "toolkit/README.md"
check_file "toolkit/starter-pack/README.md"
check_file "toolkit/starter-pack/START-HERE.md"
check_file "toolkit/vendor-pack/README.md"
check_file "toolkit/templates/README.md"
check_file "toolkit/checklists/README.md"

# Documentation
echo "=== Checking documentation files ==="
check_file "docs/project/credentials.md"
check_file "docs/23-faq.md"

# Scripts
echo "=== Checking scripts ==="
check_file "maint/scripts/check-toolkit-quality.sh"
if [[ -x "$ROOT_DIR/maint/scripts/check-toolkit-quality.sh" ]]; then
  pass "check-toolkit-quality.sh executable"
else
  fail "check-toolkit-quality.sh not executable"
fi

# GitHub community files
echo "=== Checking GitHub community files ==="
check_file ".github/CODE_OF_CONDUCT.md"
check_file ".github/CONTRIBUTING.md"
check_file ".github/SUPPORT.md"

# Summary
echo "=== Link audit complete ==="
if [[ "$FAILURES" -gt 0 ]]; then
  printf 'Link audit failed: %s issues\n' "$FAILURES"
  exit 1
fi

printf 'Link audit passed.\n'
exit 0
