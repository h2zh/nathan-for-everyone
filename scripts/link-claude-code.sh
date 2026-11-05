#!/usr/bin/env bash
# Symlink every skill folder in this repo into ~/.claude/skills so Claude Code
# (and the Claude desktop app's Code tab) loads it. Edits in the repo apply live.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DEST="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"
mkdir -p "$DEST"
for skill_md in "$ROOT"/*/SKILL.md; do
  src="$(dirname "$skill_md")"
  name="$(basename "$src")"
  if [ -e "$DEST/$name" ] && [ ! -L "$DEST/$name" ]; then
    echo "skip $DEST/$name: a real folder already exists there" >&2
    continue
  fi
  ln -sfn "$src" "$DEST/$name"
  echo "linked $DEST/$name -> $src"
done
