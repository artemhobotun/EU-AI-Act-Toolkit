#!/usr/bin/env bash
# shellcheck shell=bash
# Shared helpers for check-toolkit-quality.sh (sourced, not executed).
# Expects ROOT_DIR to be set by the caller.

: "${ROOT_DIR:?ROOT_DIR must be set before sourcing quality-lib.sh}"

FAILURES=0

pass() {
  printf 'PASS: %s\n' "$1"
}

fail() {
  printf 'FAIL: %s\n' "$1"
  FAILURES=$((FAILURES + 1))
}

check_file() {
  local file="$1"
  if [[ -f "$ROOT_DIR/$file" ]]; then
    pass "Required file present: $file"
  else
    fail "Required file missing: $file"
  fi
}

check_contains() {
  local file="$1"
  local needle="$2"
  if grep -Fqi "$needle" "$ROOT_DIR/$file"; then
    pass "Found wording in $file: $needle"
  else
    fail "Missing wording in $file: $needle"
  fi
}

check_not_contains_file() {
  local file="$1"
  local needle="$2"
  if grep -Fqi "$needle" "$ROOT_DIR/$file"; then
    fail "Forbidden wording found in $file: $needle"
  else
    pass "Forbidden wording absent in $file: $needle"
  fi
}

check_not_contains_repo() {
  local needle="$1"
  local matches
  local grep_args=(
    grep -RInF
    --exclude-dir=.git
    --exclude=check-toolkit-quality.sh
    --exclude=quality-lib.sh
  )
  if [[ "$needle" == "guaranteed compliant" ]]; then
    grep_args+=(--exclude='.github/PULL_REQUEST_TEMPLATE.md')
  fi
  grep_args+=("$needle" "$ROOT_DIR")
  matches="$("${grep_args[@]}" || true)"
  matches="$(printf '%s\n' "$matches" | grep -vF "does not guarantee compliance" || true)"
  if [[ -n "$matches" ]]; then
    fail "Forbidden wording found in repository: $needle"
  else
    pass "Forbidden wording absent: $needle"
  fi
}

check_hygiene_pattern() {
  local pattern="$1"
  if [[ "$pattern" == ".DS_Store" ]]; then
    find "$ROOT_DIR" \( -path "$ROOT_DIR/.git" -o -name node_modules \) -prune -o -type f -name "$pattern" -exec rm -f {} +
  fi
  if find "$ROOT_DIR" \( -path "$ROOT_DIR/.git" -o -name node_modules \) -prune -o -type f -name "$pattern" -print | grep -q .; then
    fail "Found forbidden file pattern: $pattern"
  else
    pass "No files matching pattern: $pattern"
  fi
}
