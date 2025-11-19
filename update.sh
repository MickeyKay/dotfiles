#!/usr/bin/env bash
set -euo pipefail

info() {
  printf "\n[dotfiles] %s\n" "$1"
}

update_homebrew() {
  if ! command -v brew >/dev/null 2>&1; then
    info "Homebrew not found. Skipping brew updates."
    return
  fi

  info "Updating Homebrew..."
  brew update
  brew upgrade
  brew cleanup
}

update_global_npm() {
  if ! command -v npm >/dev/null 2>&1; then
    info "npm not found. Skipping global npm updates."
    return
  fi

  info "Updating global npm packages (pnpm, vercel)..."
  npm install -g pnpm vercel
}

maybe_run_macos_updates() {
  if ! command -v softwareupdate >/dev/null 2>&1; then
    return
  fi

  read -r -p "Run macOS software updates now? [y/N] " reply
  case "${reply}" in
    [yY][eE][sS]|[yY])
      info "Checking for macOS software updates..."
      softwareupdate -ia --verbose || info "softwareupdate encountered issues; re-run manually if needed."
      ;;
    *)
      info "Skipping macOS software updates."
      ;;
  esac
}

update_homebrew
update_global_npm
maybe_run_macos_updates

info "Update complete."
