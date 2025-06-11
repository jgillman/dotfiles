# Disable files by adding .disabled extension
function disable
  if test (count $argv) -eq 0
    echo "Usage: disable <file1> [file2] [file3] ..."
    return 1
  end

  for file in $argv
    if test -e $file
      set -l new_name "$file.disabled"
      if mv $file $new_name
        echo "Disabled: $file -> $new_name"
      else
        echo "Error: Failed to disable $file"
      end
    else
      echo "Error: $file does not exist"
    end
  end
end
