function mount_crypt_if_needed() {
  if ! mount | grep "${HOME}/dropbox-crypt" > /dev/null; then
    ${HOME}/Dropbox/uncrypt.sh
  else
    return 0
  fi
}

alias notes='mount_crypt_if_needed && terminal_velocity'
alias scratch='mount_crypt_if_needed && vim ~/dropbox-crypt/notes/goldbelly/scratch.md'
