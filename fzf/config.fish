if _has fzf

  if _has fd
    # Use fd if available
    set -gx FZF_DEFAULT_COMMAND 'fd --type f --strip-cwd-prefix --hidden --exclude .git'
    # To apply the command to CTRL-T as well
    # set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
  end

  # Set color theme
  set -Ux FZF_DEFAULT_OPTS "
    --color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9
    --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9
    --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6
    --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4"

  # Preview file content using bat (https://github.com/sharkdp/bat)
  set -gx FZF_CTRL_T_OPTS "
    --walker-skip .git,node_modules,target
    --preview 'bat -n --color=always {}'
    --bind 'ctrl-/:change-preview-window(down|hidden|)'"




  fzf --fish | source
end
