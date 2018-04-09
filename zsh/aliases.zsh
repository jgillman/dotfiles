alias reload!='. ~/.zshrc'

alias ack="ack-grep"
alias bu='bundle '
alias brs='bin/rspec -f documentation'
alias brsx='brs $(git status | grep spec | grep "modified:" | cut -b 14- )'
alias fn='find . -name'
alias hcons='heroku run rails console -a goldbely'
alias la='ls -alG'
alias tmuxa='tmux attach || tmux new'

# Flush Directory Service cache
alias flush="dscacheutil -flushcache"

# Start a webserver in the current dir, stolen from @stevenmbone
alias servethis="open http://0.0.0.0:8000 && python -m SimpleHTTPServer"

function backup() { cp ${1}{,.bak}; }
function fname() { find . -iname "*$@*"; }
function psgrep() { ps axuf | grep -v grep | grep "$@" -i; }
