t() { tmuxinator start $1; }
te() { $EDITOR ~/.tmuxinator/; }
_t() { _values 'configs' `find ~/.tmuxinator/* -name \*.yml | cut -d/ -f5 | sed s:.yml::g`; }
alias tq="tmux kill-session -t"

# tmux
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

