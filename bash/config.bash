# Color
export CLICOLOR=true
export LSCOLORS="gxfxcxdxbxegedabagacad"

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Prefer US English and use UTF-8
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

# Double check Ctrl + D
export IGNOREEOF=1

export DISPLAY=:0.0
export MANPATH=/opt/local/man:$MANPATH

# Make vim the default editor
export EDITOR="vim"
# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"

# Make some commands not show up in history
export HISTIGNORE="ls:ls *:cd:cd -:pwd;exit:date:* --help"
