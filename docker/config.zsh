# Enable docker if it's available
if hash docker-machine 2>/dev/null; then
  eval $(docker-machine env default)
fi
