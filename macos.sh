#!/usr/bin/env bash
set -euo pipefail

echo "[dotfiles] Applying macOS defaults..."

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Fast key repeat
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Avoid creating .DS_Store on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Dock: auto hide
defaults write com.apple.dock autohide -bool true

# Apply changes
killall Dock Finder 2>/dev/null || true

echo "[dotfiles] macOS defaults applied. Some changes may require logout or restart."
