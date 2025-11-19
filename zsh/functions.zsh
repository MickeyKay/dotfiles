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
