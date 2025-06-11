# Enable files by removing .disabled extension
function enable
  if test (count $argv) -eq 0
    echo "Usage: enable <file1> [file2] [file3] ..."
    return 1
  end

  for file in $argv
    if test -e $file
      if string match -q "*.disabled" $file
        set -l new_name (string replace -r '\.disabled$' '' $file)
        if mv $file $new_name
          echo "Enabled: $file -> $new_name"
        else
          echo "Error: Failed to enable $file"
        end
      else
        echo "Warning: $file does not have .disabled extension"
      end
    else
      echo "Error: $file does not exist"
    end
  end
end

