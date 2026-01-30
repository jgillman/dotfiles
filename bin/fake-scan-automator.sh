#!/bin/bash
# This script takes a PDF or list of PDFs and outputs a file(s)
# named <file>_scanned.pdf that looks like it has been scanned
#
# Requires imagemagic and poppler to be installed (brew install imagemagick poppler)
#
# Accepts: a list of files
# Usage: ./<scriptfilename> pdf1.pdf pdf2.pdf
#
# To use as a macOS automator quick action you need to:
# - Create a new quick action that receives files or folders
# - Add a shell script
# - Paste in this script
set -e

for file in "$@"; do
  base=${file%.pdf}
  base=$base"_scanned.pdf"

  # Split PDF into pages
  echo "Splitting $base into separate pages"
  pdfseparate "$file" /tmp/fake-scan-split-%04d.pdf

  # Loop over the pages
  for splitFile in /tmp/fake-scan-split-*.pdf; do
    splitFileBase=${splitFile%.pdf}
    splitFileScanned=$splitFileBase"_scanned.pdf"

    # Slightly rotate page, add a bit of noise and output a flat pdf
    convert -density 200 -trim -flatten "$splitFile" -attenuate 0.2 +noise Gaussian -rotate "$([ $((RANDOM % 2)) -eq 1 ] && echo -)0.$(($RANDOM % 8 + 1))" "$splitFileScanned"
    echo "Output page $splitFileBase to $splitFileScanned"
  done

  # Combine the PDFs, add noise across the entire document, apply sharpening, convert to b&w, soften the blacks slightly
  convert -density 200 $(ls -rt /tmp/fake-scan-split-*_scanned.pdf) -attenuate 0.2 +noise Multiplicative -sharpen 0x1.0 -colorspace Gray +level 15%,100% "$base"
  echo "PDF re-combined to $base"

  # Remove all the temporary PDFs
  echo "Cleaning up"
  rm /tmp/fake-scan-split-*.pdf
done
