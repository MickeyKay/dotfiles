# Mickey's Dotfiles

These dotfiles are meant to get me from a **fresh Mac** to a **fully usable dev machine** as quickly and repeatably as possible.

They handle:

- Homebrew + core CLI tools
- App installs (Chrome, Alfred, Sublime, Slack, etc.)
- zsh + oh-my-zsh (with git plugin)
- Node via nvm (LTS) + pnpm + vercel CLI
- Git config + global ignore
- macOS defaults (key repeat, tap-to-click, .DS_Store behavior, etc.)
  - Trackpad speed: adjust `com.apple.trackpad.scaling` / `com.apple.mouse.scaling` values in `macos.sh`
- SSH key helper
- Update helper (`update.sh`) for brew/npm refresh
- Project helper (`bin/mkproj`) for new repos under `~/projects`
- Agent guide (`AGENTS.md`) for Codex/LLM contributors
- Optional update helper (`update.sh`) for brew/npm refresh
- Agent guide (`AGENTS.md`) for Codex/LLM contributors

When adding new apps/CLI tools, prefer updating `Brewfile` (cask/formula) and installing via `brew bundle --file Brewfile --no-lock` or `./update.sh` so future machines stay in sync. See `CONTRIBUTING.md` for a quick checklist.

---

## Quick Start (New Machine)

```bash
# 1. Clone dotfiles
git clone git@github.com:YOUR_GITHUB_USERNAME/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# 2. Make bootstrap executable
chmod +x bootstrap.sh

# 3. Run bootstrap
./bootstrap.sh
```

This will:

- Ensure Xcode Command Line Tools
- Install Homebrew
- Run the `Brewfile` (CLI tools + apps)
- Install oh-my-zsh
- Symlink zsh + git config files
- Set default shell to zsh
- Apply macOS defaults (via `macos.sh`)

Then:

```bash
# Generate and register SSH key (GitHub, etc.)
~/.dotfiles/bin/setup_ssh.sh your-email@example.com

# Create a new project folder
~/.dotfiles/bin/mkproj my-new-app

# Update brew/npm and (optionally) macOS updates
./update.sh
```

Open a new terminal window (or `source ~/.zshrc`) and you should be in your new environment.

---

## What `bootstrap.sh` Handles

- **Xcode CLI tools** – required for git, compilers, etc.
- **Homebrew** – package manager for everything else
- **Brewfile** – installs:
  - CLI: git, nvm, gh, wget, jq, ripgrep, fzf, etc.
  - GUI apps: iTerm2, Chrome, Alfred, Discord, Flux, Flycut, Gifox, Moom, Slack, Sublime Text, Transmit, Xcode
- **oh-my-zsh** – shell framework + git plugin
- **Node tooling**:
  - nvm
  - Node LTS
  - global: `pnpm`, `vercel`
- **Symlinks**:
  - `~/.zshrc` → `zsh/zshrc`
  - `~/.gitconfig` → `git/gitconfig`
  - `~/.gitignore_global` → `git/gitignore_global`
- **macOS defaults** – a few opinionated system tweaks
- **Update helper** – `update.sh` for brew/npm refresh and optional macOS updates

---

## Manual Setup Steps (Not Automated Yet)

These are things I still do manually. Documenting them here so future-me remembers **what** and **why**.

### 1. Install ChatGPT Desktop
- **How**: Download from OpenAI’s site and install.
- **Why**: Native app for faster access to ChatGPT; not managed via Homebrew (yet / by choice).

### 2. Install Codex CLI
- **How**: Follow the official Codex CLI installation instructions.
- **Why**: Useful for command-line assistance / generation. Keeping it manual so it can evolve independently of dotfiles.

### 3. Install Zoom
- **How**: Download the latest Zoom client from zoom.us and install it manually.
- **Why**: Prefer handling Zoom outside Homebrew to keep control over updates and permissions.

### 4. Install Docker Desktop
- **How**: Download Docker Desktop from docker.com and install it manually.
- **Why**: Keeps control over version/updates and avoids auto-install during bootstrap.

### 5. Set Chrome as Default Browser
- **How**:  
  `System Settings → Desktop & Dock → Default web browser → Google Chrome`
- **Why**: I prefer Chrome for dev + everyday browsing. This setting tends to be a bit brittle to script, so I configure it once per machine.

### 6. Sign In to Core Accounts
- **How**:
  - Chrome (profile sync: bookmarks, extensions)
  - GitHub (web + `gh auth login`)
  - Vercel (`vercel login`)
  - Slack workspaces
- **Why**: Restores all the cloud-side state (bookmarks, repos, projects, etc.) that dotfiles intentionally don’t manage.

### 7. Restore App Licenses and Preferences
- **Apps**:
  - Alfred (PowerPack license + sync prefs if applicable)
  - Moom
  - Sublime Text
  - Transmit (favorites can be restored from cloud / manual export if needed)
- **Why**: License keys and some app-specific preferences are sensitive / personal; better restored from my password manager or manual backup than hard-coded.

### 8. (Optional) Customize macOS Settings Beyond `macos.sh`
- Dock layout
- Trackpad gestures
- Display / Night Shift specifics, etc.
- Scroll direction (I prefer traditional / not "natural"):
  `System Settings → Trackpad → Scroll & Zoom → Scroll direction: Natural` (turn this **off**)
- iTerm2 new tabs reuse working dir:
  `iTerm2 → Settings → Profiles → (profile) → General → Initial directory → Reuse previous session's directory`

These can be added gradually to `macos.sh` if I decide they’re worth automating.

### 9. Point iTerm2 at repo-managed preferences
- **How**: `iTerm2 → Settings → General → Preferences` → enable “Load preferences from a custom folder or URL” → set folder to `~/.dotfiles` (or wherever this repo lives). Restart iTerm2 to pick up `com.googlecode.iterm2.plist`.
- **Why**: Keeps iTerm2 color/profile tweaks in sync without manually reapplying them on new machines.

### 10. Install Sublime Text Package Control
- **How**: Open Sublime Text → `Cmd+Shift+P` → “Install Package Control” (or `Tools → Install Package Control`), then restart Sublime Text once.
- **Why**: Package Control is needed to restore packages from synced settings; installing it once ensures the user repo can pull in dependencies automatically.

### 11. Sync Sublime Text User settings
- **How**: Run `~/.dotfiles/bin/sync_sublime_user` to clone/pull `git@github.com:MickeyKay/Sublime-User-Package.git` into Sublime Text 4’s `Packages/User` directory. Override the target with `SUBLIME_USER_DIR`, or change the source with `SUBLIME_USER_REPO`.
- **Why**: Keeps Sublime Text preferences in sync across machines without manual export/import. The helper is idempotent and refuses to overwrite non-git content or dirty working copies.

---

## Conventions

- Primary code directory: `~/projects`
- Shell: zsh + oh-my-zsh
- Editor: Sublime Text (`subl -w`)
- Node: nvm-managed, LTS as default
- Git: `main` as default branch, global ignore file in `git/gitignore_global`

---

## Rerunning Bootstrap

It should be generally safe to rerun:

```bash
cd ~/.dotfiles
./bootstrap.sh
```

It will:

- Skip installing things that already exist
- Backup pre-existing config files to `*.backup` before relinking

Use this when you add new tools to your `Brewfile` or adjust configuration.
