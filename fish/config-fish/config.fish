# If not running interactively, don't do anything
if not status is-interactive
    exit
end

# shortcut to this dotfiles path is $DOTFILES
set -gx DOTFILES $HOME/.dotfiles

function fish_greeting
    # If figlet is installed, print the hostname for new session
    if _has figlet
        hostname -s | figlet -w 120 -f slant
    else
        echo You\'re on (set_color yellow)$hostname(set_color normal).
    end
end

# all of our fish files
set config_files (find $DOTFILES -name "*.fish" -type f -maxdepth 3)

# load the path files as long as we're not in a multiplexer
if not set -q TMUX; and not set -q HERDR_ENV
    for file in $config_files
        if string match -q "*/path.fish" $file
            source $file
        end
    end
end

abbr --add -g .. 'cd ..'
abbr --add -g ... 'cd ../..'
abbr --add -g .... 'cd ../../..'

abbr --add -g clock tty-clock
abbr --add -g llg 'll | grep -i'

if _has lazygit
    abbr --add -g lazy lazygit
end

if _has rg
    abbr --add -g ag rg
end

if _has claude
    abbr --add -g qq claude --model haiku
    abbr --add -g cladue claude
end

if _has atuin
    abbr --add -g autin atuin
end

# load everything but the path files
for file in $config_files
    if not string match -q "*/path.fish" $file; and not string match -q "*/fish/config-fish/*" $file
        source $file
    end
end
