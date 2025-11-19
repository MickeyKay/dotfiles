#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${HOME}/.dotfiles"

info() {
  printf "\n[dotfiles] %s\n" "$1"
}

# 1. Xcode command line tools
install_xcode_cli() {
  if ! xcode-select -p >/dev/null 2>&1; then
    info "Installing Xcode Command Line Tools..."
    xcode-select --install || true
    info "If a popup appeared, accept it, let it finish, then rerun this script."
  else
    info "Xcode Command Line Tools already installed."
  fi
}

# 2. Homebrew
install_homebrew() {
  if ! command -v brew >/dev/null 2>&1; then
    info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    info "Homebrew already installed."
  fi

  # Apple Silicon Homebrew shellenv
  if [ -d "/opt/homebrew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    if ! grep -q 'eval "$(/opt/homebrew/bin/brew shellenv)"' "${HOME}/.zprofile" 2>/dev/null; then
      echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "${HOME}/.zprofile"
    fi
  fi
}

# 3. Brewfile
run_brewfile() {
  if [ -f "${DOTFILES_DIR}/Brewfile" ]; then
    info "Running Brewfile..."
    brew bundle --file="${DOTFILES_DIR}/Brewfile"
  else
    info "No Brewfile found, skipping."
  fi
}

# 4. oh-my-zsh
install_oh_my_zsh() {
  if [ ! -d "${HOME}/.oh-my-zsh" ]; then
    info "Installing oh-my-zsh..."
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  else
    info "oh-my-zsh already installed."
  fi
}

# 5. Symlinks
link_file() {
  local src="$1"
  local dest="$2"

  if [ -L "${dest}" ] || [ -f "${dest}" ]; then
    if [ "$(readlink "${dest}" 2>/dev/null)" = "${src}" ]; then
      info "Link already exists: ${dest}"
      return
    fi
    info "Backing up existing file: ${dest} -> ${dest}.backup"
    mv "${dest}" "${dest}.backup"
  fi

  ln -s "${src}" "${dest}"
  info "Linked ${dest} -> ${src}"
}

link_dotfiles() {
  info "Linking dotfiles..."

  # zsh main rc
  link_file "${DOTFILES_DIR}/zsh/zshrc" "${HOME}/.zshrc"

  # git
  link_file "${DOTFILES_DIR}/git/gitconfig" "${HOME}/.gitconfig"
  link_file "${DOTFILES_DIR}/git/gitignore_global" "${HOME}/.gitignore_global"
}

# 6. Default shell
set_default_shell_to_zsh() {
  if [ "$SHELL" != "/bin/zsh" ]; then
    info "Setting default shell to zsh..."
    chsh -s /bin/zsh || info "Could not change shell automatically; set it manually in System Settings."
  else
    info "Default shell already zsh."
  fi
}

# 7. Node + global tools
install_node_and_global_tools() {
  info "Ensuring Node LTS + global tools via nvm..."

  # Make sure Homebrew nvm is wired, even if zshrc isn't loaded yet
  export NVM_DIR="${HOME}/.nvm"
  if [ -s "/opt/homebrew/opt/nvm/nvm.sh" ]; then
    . "/opt/homebrew/opt/nvm/nvm.sh"
  else
    info "nvm not found via Homebrew. Did Brewfile run correctly?"
    return
  fi

  # Install/use LTS
  nvm install --lts || true
  nvm use --lts || true
  nvm alias default 'lts/*' || true

  # Global npm tools
  if command -v npm >/dev/null 2>&1; then
    info "Installing global npm tools (pnpm, vercel)..."
    npm install -g pnpm vercel || info "Global npm installs had issues; you can rerun them manually."
  fi
}

# 8. macOS defaults
run_macos_defaults() {
  if [ -f "${DOTFILES_DIR}/macos.sh" ]; then
    info "Applying macOS defaults (you may be prompted for password)..."
    bash "${DOTFILES_DIR}/macos.sh" || info "macos.sh encountered issues; review output."
  fi
}

main() {
  install_xcode_cli
  install_homebrew
  run_brewfile
  install_oh_my_zsh
  link_dotfiles

  # Ensure ~/projects directory exists
  if [ ! -d "${HOME}/projects" ]; then
    info "Creating ~/projects directory..."
    mkdir -p "${HOME}/projects"
  fi

  set_default_shell_to_zsh
  install_node_and_global_tools
  run_macos_defaults

  info "Bootstrap complete. Open a new terminal or run: source ~/.zshrc"
}

main "$@"
