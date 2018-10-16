#!/usr/bin/env bash

main() {
  local source="$ZSH/kitty/config-kitty"
  local target="${HOME}/.config/kitty"

  if [ -e "$target" ]; then
    echo "$target already exists."
  else
    ln -s "$source" "$target"
    echo "Linked $source to $target"
  fi
}

main
