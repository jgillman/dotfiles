# Find directories by name
function findd
  set -l search ""
  set -l search_dir ""

  if test -d $argv[1]
    set search_dir $argv[1]
    set search $argv[2]
  else
    set search_dir "."
    set search $argv[1]
  end

  find $search_dir -type d -iname "*$search*"
end
