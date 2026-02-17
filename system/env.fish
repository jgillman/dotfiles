# Set the default editor
if _has nvim
  set -gx VISUAL nvim
  set -gx EDITOR nvim
else
  set -gx VISUAL vim
  set -gx EDITOR vim
end

if _has bat
  set -gx MANPAGER 'sh -c "col -bx | bat -plman"'
  set -gx MANROFFOPT "-c"
else
  set -gx MANPAGER "less -X"
end
