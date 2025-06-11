# If not running interactively, don't do anything
if not status is-interactive
  exit
end


# shortcut to this dotfiles path is $DOTFILES
set -gx DOTFILES $HOME/.dotfiles

# set default editor
set -gx VISUAL vim
set -gx EDITOR vim

function fish_greeting
  # If figlet is installed, print the hostname for new session
  if _has figlet
    hostname -s | figlet -w 120 -f slant
  else
    echo You\'re on (set_color yellow)$hostname(set_color normal).
  end
end

# all of our fish files
set config_files (find $DOTFILES -name "*.fish" -type f)


if not set -q TMUX
  # load the path files
  for file in $config_files
    if string match -q "*/path.fish" $file
      source $file
    end
  end
end

# load everything but the path files
for file in $config_files
  # if not string match -q "*/path.fish" $file; and not string match -q "*/completion.fish" $file
  if not string match -q "*/path.fish" $file; and not string match -q "*/fish/config-fish/*" $file
    source $file
  end
end

# use .localrc for SUPER SECRET CRAP that you don't want in your public,
# versioned repo. This should be last so it can override global configs.
if test -f ~/.localrc
  source ~/.localrc
end
if test -f ~/.localrc.fish
  source ~/.localrc.fish
end
