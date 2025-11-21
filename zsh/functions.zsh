# Jump into a project under ~/projects by name
proj() {
  if [ -z "$1" ]; then
    cd "$PROJECTS_DIR"
  else
    cd "$PROJECTS_DIR/$1" 2>/dev/null || {
      echo "Project '$1' not found under $PROJECTS_DIR"
      return 1
    }
  fi
}

# Notify once per dirty state when working inside ~/.dotfiles so changes get reviewed
dotfiles_notify_dirty_hook() {
  [ "${DOTFILES_NOTIFY_DIRTY:-1}" -eq 0 ] && return

  local dir="${DOTFILES_DIR:-$HOME/.dotfiles}"
  case "$PWD"/ in
    "$dir"/|"$dir"/*) ;;
    *) return ;;
  esac

  command git -C "$dir" rev-parse --is-inside-work-tree >/dev/null 2>&1 || return
  local dirty_state
  dirty_state="$(command git -C "$dir" status --porcelain --ignore-submodules=dirty 2>/dev/null)" || return

  if [ -n "$dirty_state" ]; then
    if [ "$DOTFILES_NOTIFY_DIRTY_LAST_STATE" != "dirty" ]; then
      local warn_color reset_color
      if [ -t 1 ]; then
        warn_color=$'\033[33m'
        reset_color=$'\033[0m'
      fi
      printf "\n%s[dotfiles] WARNING:%s repo has unstaged changes in %s. Run 'git status' to review and commit/push.\n\n" "${warn_color:-}" "${reset_color:-}" "$dir"
      if command -v osascript >/dev/null 2>&1; then
        osascript -e 'display notification "Dotfiles have unstaged changes" with title "dotfiles"'
      fi
    fi
    DOTFILES_NOTIFY_DIRTY_LAST_STATE="dirty"
  else
    DOTFILES_NOTIFY_DIRTY_LAST_STATE="clean"
  fi
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd dotfiles_notify_dirty_hook
