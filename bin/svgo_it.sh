#!/usr/bin/env bash

# Automatically optimize and inline ALL styles
# svgo_it.sh my.svg

main() {
  local input=$1
  local precision=${2:-2}
  # Move ALL styles to inline
  # disabled 23/06/08 as it doesn't appear to work now
  # local config='{ "plugins": [{ "inlineStyles": { "onlyMatchedOnce": false } }] }'

  svgo -i "$input" -o "${input}.opt.svg" --precision="$precision" --multipass
}

main "$@"
