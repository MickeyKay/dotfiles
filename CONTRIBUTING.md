# Contributing / Adding Tools

This repo is meant to stay simple and reproducible. When you add a new app or CLI, prefer managing it via Homebrew so future machines get it automatically.

## Adding an app or CLI
- Add it to `Brewfile` (use `brew search <name>` to confirm cask/formula).
- If it needs config files, add them under this repo and symlink via `bootstrap.sh` or a dedicated helper.
- If it needs macOS defaults, add them to `macos.sh` (grouped by section) and keep them idempotent.
- Run `brew bundle --file Brewfile --no-lock` to install locally, or just run `./update.sh` to pick up new items.
- Note any manual follow-up (licenses, logins, GUI toggles) in README’s Manual Setup section.

## Principles
- Idempotent: scripts safe to re-run; avoid destructive changes.
- Minimal: keep dependencies reasonable; ask before large additions.
- Reversible: back up or prompt before overwriting user files.

## Quick checklist for new items
- [ ] Added to `Brewfile` (cask or formula)
- [ ] Any configs checked into repo and linked via `bootstrap.sh` (if needed)
- [ ] Manual steps documented in README (if any)
- [ ] Optional: mention in `AGENTS.md` if agent behavior should change
