#!/usr/bin/env bash

# Automatically optimize and inline ALL styles
# svgo_it.sh my.svg

main() {
  local input=$1
  # Move ALL styles to inline
  local config='{ "plugins": [{ "inlineStyles": { "onlyMatchedOnce": false } }] }'

  svgo -i "$input" -o "${input}.opt.svg" --precision=2 --multipass --config="${config}"
}

main "$@"
