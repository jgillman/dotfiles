#!/usr/bin/env bash

main() {
  local base_dir=
  base_dir=$( basename "$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )" )

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
