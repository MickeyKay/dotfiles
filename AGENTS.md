# Agents Guide

This repo is already working; aim to keep changes minimal, readable, and idempotent.

## How to Work Here
- Start with a quick review; propose risky changes before editing.
- Show diffs for non-trivial edits; keep commits small and reversible.
- Preserve idempotence (scripts safe to re-run, symlink-friendly) and avoid destructive commands.
- Ask before adding new dependencies or altering macOS/system-wide behavior.
- Prefer `apply_patch` for edits; mention any commands you run. Use prompts for actions that need user interaction.

## Layout Primer
- `bootstrap.sh`: end-to-end setup (Xcode CLI, Homebrew + Brewfile, oh-my-zsh, symlinks, Node via nvm, macOS defaults).
- `update.sh`: brew update/upgrade/cleanup + global npm refresh; optional macOS updates.
- `macos.sh`: opinionated defaults (key repeat, Finder extensions, Dock hide). Add tweaks in sections.
- `Brewfile`: CLI tools and apps managed by Homebrew Bundle.
- `zsh/`: shell config (`zshrc`, `aliases.zsh`, `exports.zsh`, `functions.zsh`, `plugins.zsh`).
- `git/`: gitconfig + global ignore.
- `bin/`: helper scripts (e.g., `setup_ssh.sh`, `mkproj`).

## Manual Tasks (stay manual unless requested)
- Set Chrome as default browser.
- Install ChatGPT desktop and Codex CLI.
- Sign into Chrome, GitHub/gh, Vercel, Slack; restore app licenses (Alfred, Moom, Sublime, Transmit).
- Any sensitive keys, tokens, or license files.

## mkproj Helper
- `bin/mkproj <name>` makes `~/projects/<name>` and can init git on prompt.
- Keep `~/projects` as the primary workspace.

## Requesting Changes
- Spell out the goal and acceptable scope; flag anything destructive.
- Note whether to run `bootstrap.sh`/`update.sh` or leave scripts untouched.
- If adding apps/tools, update `Brewfile` and mention any manual follow-up needed.
