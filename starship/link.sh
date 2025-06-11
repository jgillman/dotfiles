#!/usr/bin/env bash

main() {
  # Set base_dir to the name of the directory or program
  local base_dir="starship"

  local source="$DOTFILES/${base_dir}/${base_dir}.toml"
  local target="${HOME}/.config/${base_dir}.toml"

  if [ -e "$target" ]; then
    echo "$target already exists."
  else
    ln -s "$source" "$target"
    echo "Linked $source to $target"
  fi
}

main
