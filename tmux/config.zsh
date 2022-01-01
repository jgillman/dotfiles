# Set bindings for zsh-history-substring-search

# bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# bind P and N for EMACS mode
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Bind up and down keys for Ubuntu
if [[ `uname` == 'Linux' ]]
then
  # bind UP and DOWN arrow keys
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
fi

set-option -g mouse on
