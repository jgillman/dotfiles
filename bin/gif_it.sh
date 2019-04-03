#!/usr/bin/env bash
#
# gif_it.sh can take any video file that ffmpeg can handle. It first generates
# a color palette of the entire video and then uses that when creating the gif.
# This creates a less-noisey and better looking gif.
#
# Usage:
#
# Make a gif from 'my_movie.mp4' with a width of 500 at 12 frames per second
#   gif_it.sh my_movie.mp4 500 12
#
# Make a gif from 'my_movie.mov with the default width of 540 and 15 fps
#   gif_it.sh my_movie.mov

readonly input=$1
readonly output="$input.gif"

readonly width=${2:-540}
readonly framerate=${3:-15}

readonly palette="/tmp/palette-$(uuidgen).png"
readonly filters="fps=${framerate},scale=${width}:-1:flags=lanczos"

ffmpeg -y -v warning -i "${input}" -vf "${filters},palettegen=stats_mode=diff" "${palette}" &&
ffmpeg -y -v warning -i "${input}" -i "${palette}" -lavfi "${filters} [x]; [x][1:v] paletteuse=dither=bayer:bayer_scale=5:diff_mode=rectangle" "${output}"
