#!/usr/bin/env bash
# Build upload-ready ZIPs (one top-level folder containing SKILL.md) for
# claude.ai / Claude Duet and ChatGPT / OpenAI Dots.
# Usage: scripts/package.sh            -> dist/<skill>.zip for every skill folder
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
mkdir -p "$ROOT/dist"
for skill_md in "$ROOT"/*/SKILL.md; do
  dir="$(basename "$(dirname "$skill_md")")"
  out="$ROOT/dist/$dir.zip"
  rm -f "$out"
  (cd "$ROOT" && zip -qr "$out" "$dir" -x '*.DS_Store' "$dir/references/sources/*")
  echo "built $out ($(du -h "$out" | cut -f1))"
done
