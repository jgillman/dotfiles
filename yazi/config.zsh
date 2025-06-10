if _has yazi; then

  export YAZI_CONFIG_HOME=$DOTFILES/yazi

  # Use `y` instead of `yazi` to start, and press `q` to quit, you'll see the
  # CWD changed. Sometimes, you don't want to change, press `Q` to quit.
  function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
  }

fi
