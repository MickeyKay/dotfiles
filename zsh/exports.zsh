# General env
export EDITOR="subl -w"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Primary projects directory
export PROJECTS_DIR="${HOME}/projects"

# Homebrew (Apple Silicon)
if [ -d "/opt/homebrew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# nvm
export NVM_DIR="${HOME}/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# Node default version (safe if alias missing)
if command -v nvm >/dev/null 2>&1; then
  nvm alias default 'lts/*' >/dev/null 2>&1 || true
fi

# Paths
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
