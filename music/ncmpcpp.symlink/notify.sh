#!/usr/bin/env bash

title="$(mpc current -f '%title%')"
subtitle="$(mpc current -f '%artist%')"
message="$(mpc current -f '%album%')"
artwork="$(dirname "${XDG_MUSIC_DIR}/$(mpc current -f '%file%')")/albumart.jpg"

send_notification() {
  if [ -f "$artwork" ]; then
    terminal-notifier \
      -title "$title" \
      -subtitle "$subtitle" \
      -message "$message" \
      -contentImage "$artwork"
  else
    terminal-notifier \
      -title "$title" \
      -subtitle "$subtitle" \
      -message "$message"
  fi
}

main() {
  if type terminal-notifier >/dev/null 2>&1; then
    send_notification
  else
    echo "Please install terminal-notifier"
    exit 1
  fi
}

main "$@"
