[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# if _has ag; then
#   export FZF_DEFAULT_COMMAND='ag -g ""'
# fi

# fzf via Homebrew
if [ -e /usr/local/opt/fzf/shell/completion.zsh ]; then
  source /usr/local/opt/fzf/shell/key-bindings.zsh
  source /usr/local/opt/fzf/shell/completion.zsh
fi

# fzf via local installation
# if [ -e ~/.fzf ]; then
#   _append_to_path ~/.fzf/bin
#   source ~/.fzf/shell/key-bindings.zsh
#   source ~/.fzf/shell/completion.zsh
# fi

# fzf + ag configuration
# if _has fzf && _has ag; then
#   export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
#   export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
#   export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
#   export FZF_DEFAULT_OPTS='
#   --color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108
#   --color info:108,prompt:109,spinner:108,pointer:168,marker:168
#   '
# fi
