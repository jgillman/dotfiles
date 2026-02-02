# Find and remove annoying .DS_Store files
function cleanup
  find . -name '*.DS_Store' -type f -ls -delete
end
