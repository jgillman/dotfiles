#!/usr/bin/env bash

main() {
  # Set base_dir to the name of the directory or program
  local base_dir="gitui"

  local source="$DOTFILES/${base_dir}/config-${base_dir}"
  local target="${HOME}/.config/${base_dir}"

  if [ -e "$target" ]; then
    echo "$target already exists."
  else
    ln -s "$source" "$target"
    echo "Linked $source to $target"
  fi
}

main
