alias reload!='. ~/.zshrc'

alias la='ls -alG'
alias ack="ack-grep"
alias bu='bundle '
alias brs='bin/rspec -f documentation'
alias fn='find . -name'
alias tmuxa='tmux attach || tmux new'

# Flush Directory Service cache
alias flush="dscacheutil -flushcache"

# Start a webserver in the current dir, stolen from @stevenmbone
alias servethis="open http://0.0.0.0:8000 && python -m SimpleHTTPServer"

function backup() { cp ${1}{,.bak}; }
function fname() { find . -iname "*$@*"; }
function psgrep() { ps axuf | grep -v grep | grep "$@" -i; }
