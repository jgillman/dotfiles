if _has fzf
  fzf --fish | source

  if _has fd
    # Use fd if available
    set -gx FZF_DEFAULT_COMMAND 'fd --type f --strip-cwd-prefix'
    # To apply the command to CTRL-T as well
    set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
  end
end
