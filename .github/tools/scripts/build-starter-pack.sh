#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
ZIP_PATH="$ROOT_DIR/dist/eu-ai-act-sme-starter-pack.zip"

mkdir -p "$ROOT_DIR/dist"

if ! command -v zip >/dev/null 2>&1; then
  printf 'WARNING: zip command not found; starter pack ZIP was not created.\n'
  exit 0
fi

rm -f "$ZIP_PATH"

(cd "$ROOT_DIR" && zip -qr "$ZIP_PATH" \
  toolkit/starter-pack \
  toolkit/templates \
  toolkit/checklists \
  README.md \
  docs/DISCLAIMER.md \
  docs/guide/docs/guide/10-source-notes.md \
  docs/guide/docs/guide/16-what-to-escalate-for-legal-review.md \
  docs/guide/docs/guide/17-downloadable-toolkit-pack.md)

printf 'Starter pack ZIP created: %s\n' "$ZIP_PATH"
