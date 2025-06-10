if _has starship
  export STARSHIP_CONFIG=$DOTFILES/starship/starship.toml
  starship init fish | source
end
