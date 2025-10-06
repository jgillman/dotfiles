#!/usr/bin/env bash

# CHANGE THESE for where to rsync from and to
SOURCE_DIR="${HOME}/Library/Containers/engineering.teenage.fieldkit/Data/Documents/TP-7 MTP Device-F1RUI15V/"
DEST_DIR="${HOME}/recordings/TP-7"
# CHANGE THESE for where your models are located
MODEL_PATH="${HOME}/Code/whisper.cpp/models/ggml-large-v3-q5_0.bin"
VAD_MODEL_PATH="${HOME}/Code/whisper.cpp/models/ggml-silero-v5.1.2.bin"


# Don't allow unset variables
set -o nounset

# Exit immediately if a pipeline returns non-zero.
set -o errexit
# Give helpful error message if that happens
trap 'echo "Aborting due to errexit on line $LINENO. Exit code: $?" >&2' ERR
# Allow the above trap be inherited by all functions in the script.
set -o errtrace

# Return value of a pipeline is the value of the last (rightmost) command to
# exit with a non-zero status, or zero if all commands in the pipeline exit
# successfully.
set -o pipefail

# Set $IFS to only newline and tab.
#
# http://www.dwheeler.com/essays/filenames-in-shell.html
IFS=$'\n\t'


###############################################################################
# Check dependencies
###############################################################################
check_dependencies() {
  local deps=(rsync ffmpeg whisper-cli grep sed)
  local missing_deps=()

  for dep in "${deps[@]}"; do
    if ! command -v "$dep" >/dev/null 2>&1; then
      missing_deps+=("$dep")
    fi
  done

  if [[ ${#missing_deps[@]} -gt 0 ]]; then
    echo "Error: The following required dependencies are missing:" "${missing_deps[@]}"
    exit 1
  fi
}

# Check dependencies and exit with error if any are missing
check_dependencies

###############################################################################
# Main
###############################################################################

_main() {
  local synced_files
  echo "Syncing missing files from ${SOURCE_DIR} to ${DEST_DIR}..."
  synced_files=$(rsync -avhz --itemize-changes "${SOURCE_DIR}" "${DEST_DIR}" | \
    grep -E '^>f' | \
    sed 's/^>f[^\s]* //')

  # Process only the synced files
  for file in $synced_files; do
    if [[ "$file" == *.wav ]]; then
      local file_path="${DEST_DIR}/${file}"
      printf "\nProcessing: %s\n" "$file_path"
      _normalize_volume "$file_path" | _transcribe "$file_path"
    fi
  done
}

_normalize_volume() {
  local file="$1"

  ffmpeg -hide_banner -loglevel warning -i "$file" -af loudnorm -f wav -
}

_transcribe() {
  local file="$1"
  local file_basename
  file_basename=$(basename "${file}" .wav)
  local file_dirname
  file_dirname=$(dirname "${file}")
  local transcript_file_path="${file_dirname}/${file_basename}.txt"

  whisper-cli --model "$MODEL_PATH" \
    --vad-model "$VAD_MODEL_PATH" \
    --vad \
    --language en \
    --output-txt \
    --output-file "${file_dirname}/${file_basename}" \
    --no-prints \
    --print-colors \
    -

  # Delete output if empty
  if [ ! -s "${transcript_file_path}" ]; then
    printf "No dialog found. Removing empty transcription file: %s\n" "$transcript_file_path"
    rm "${transcript_file_path}"
  fi
}

# Call `_main` after everything has been defined.
_main "$@"

