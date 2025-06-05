#!/usr/bin/env bash

main() {
  local source="$ZSH/video/config-mpv"
  local target="${HOME}/.config/mpv"

  if [ -e "$target" ]; then
    echo "$target already exists."
  else
    ln -s "$source" "$target"
    echo "Linked $source to $target"
  fi
}

main
