#!/usr/bin/env bash
set -euo pipefail

echo "[dotfiles] Applying macOS defaults..."

# --- General ---
# defaults write com.apple.screencapture location "${HOME}/screenshots"

# --- Finder ---
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# --- Dock ---
defaults write com.apple.dock autohide -bool true

# --- Trackpad ---
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# --- Keyboard ---
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Apply changes
killall Dock Finder 2>/dev/null || true

echo "[dotfiles] macOS defaults applied. Some changes may require logout or restart."
