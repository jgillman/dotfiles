#!/usr/bin/env bash

artwork() {
  album_dir="$(dirname "${XDG_MUSIC_DIR}/$(mpc current -f '%file%')")"

  find "$album_dir" -name '*.png' -or -name '*.jpg' -or -name '*.gif' \
    | head -1
}

send_notification() {
  local title="$(mpc current -f '%title%')"
  local subtitle="$(mpc current -f '%artist%')"
  local message="$(mpc current -f '%album%')"
  local artwork="$(artwork)"

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
