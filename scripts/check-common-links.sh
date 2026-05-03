#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FAILURES=0

pass() {
  printf 'PASS: %s\n' "$1"
}

fail() {
  printf 'FAIL: %s\n' "$1"
  FAILURES=$((FAILURES + 1))
}

# Core files
echo "=== Checking core project files ==="
test -f "$ROOT_DIR/README.md" && pass "README.md" || fail "README.md missing"
test -f "$ROOT_DIR/DISCLAIMER.md" && pass "DISCLAIMER.md" || fail "DISCLAIMER.md missing"
test -f "$ROOT_DIR/SECURITY.md" && pass "SECURITY.md" || fail "SECURITY.md missing"
test -f "$ROOT_DIR/LICENSE" && pass "LICENSE" || fail "LICENSE missing"

# HTML pages
echo "=== Checking GitHub Pages files ==="
test -f "$ROOT_DIR/docs/index.html" && pass "docs/index.html" || fail "docs/index.html missing"
test -f "$ROOT_DIR/docs/community.html" && pass "docs/community.html" || fail "docs/community.html missing"

# Toolkit structure
echo "=== Checking toolkit structure ==="
test -d "$ROOT_DIR/toolkit" && pass "toolkit/ directory" || fail "toolkit/ directory missing"
test -f "$ROOT_DIR/toolkit/README.md" && pass "toolkit/README.md" || fail "toolkit/README.md missing"
test -f "$ROOT_DIR/toolkit/starter-pack/README.md" && pass "toolkit/starter-pack/README.md" || fail "toolkit/starter-pack/README.md missing"
test -f "$ROOT_DIR/toolkit/starter-pack/START-HERE.md" && pass "toolkit/starter-pack/START-HERE.md" || fail "toolkit/starter-pack/START-HERE.md missing"
test -f "$ROOT_DIR/toolkit/vendor-pack/README.md" && pass "toolkit/vendor-pack/README.md" || fail "toolkit/vendor-pack/README.md missing"
test -f "$ROOT_DIR/toolkit/templates/README.md" && pass "toolkit/templates/README.md" || fail "toolkit/templates/README.md missing"
test -f "$ROOT_DIR/toolkit/checklists/README.md" && pass "toolkit/checklists/README.md" || fail "toolkit/checklists/README.md missing"

# Documentation
echo "=== Checking documentation files ==="
test -f "$ROOT_DIR/docs/project/credentials.md" && pass "docs/project/credentials.md" || fail "docs/project/credentials.md missing"
test -f "$ROOT_DIR/docs/23-faq.md" && pass "docs/23-faq.md" || fail "docs/23-faq.md missing"

# Scripts
echo "=== Checking scripts ==="
test -f "$ROOT_DIR/scripts/check-toolkit-quality.sh" && pass "check-toolkit-quality.sh" || fail "check-toolkit-quality.sh missing"
test -x "$ROOT_DIR/scripts/check-toolkit-quality.sh" && pass "check-toolkit-quality.sh executable" || fail "check-toolkit-quality.sh not executable"

# GitHub community files
echo "=== Checking GitHub community files ==="
test -f "$ROOT_DIR/.github/CODE_OF_CONDUCT.md" && pass ".github/CODE_OF_CONDUCT.md" || fail ".github/CODE_OF_CONDUCT.md missing"
test -f "$ROOT_DIR/.github/CONTRIBUTING.md" && pass ".github/CONTRIBUTING.md" || fail ".github/CONTRIBUTING.md missing"
test -f "$ROOT_DIR/.github/SUPPORT.md" && pass ".github/SUPPORT.md" || fail ".github/SUPPORT.md missing"

# Summary
echo "=== Link audit complete ==="
if [[ "$FAILURES" -gt 0 ]]; then
  printf 'Link audit failed: %s issues\n' "$FAILURES"
  exit 1
fi

printf 'Link audit passed.\n'
exit 0
