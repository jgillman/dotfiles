if _has starship; then
  export STARSHIP_CONFIG=$DOTFILES/starship/starship.toml
  eval "$(starship init zsh)"
fi
