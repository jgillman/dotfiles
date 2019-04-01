function notes() {
  if ! mount | grep "${HOME}/dropbox-crypt" > /dev/null; then
    ${HOME}/Dropbox/uncrypt.sh && \
      terminal_velocity
  else
    terminal_velocity
  fi
}
