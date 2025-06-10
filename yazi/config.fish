if _has yazi

  export YAZI_CONFIG_HOME=$DOTFILES/yazi

  # Use `y` instead of `yazi` to start, and press `q` to quit, you'll see the
  # CWD changed. Sometimes, you don't want to change, press `Q` to quit.
  function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
      builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
  end

end
