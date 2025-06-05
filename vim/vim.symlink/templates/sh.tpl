#!/usr/bin/env bash

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
# Main
###############################################################################

_main() {
}

# Call `_main` after everything has been defined.
_main "$@"

