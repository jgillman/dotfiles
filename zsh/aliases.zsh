alias reload!='. ~/.zshrc'

alias bu='bundle '
alias brs='bin/rspec -f documentation'
alias brsx='brs $(git status | grep "_spec\.rb" | grep "modified:" | cut -b 14- )'
alias hcons='bin/production run rails c' #  -e DISABLE_DATADOG_AGENT=true --app goldbely'
alias la='ls -alG'
alias tmuxa='tmux attach || tmux new'
alias vgs='vim `gs -s | sed "s/.. \(.*\)/\1/"`'

# Flush Directory Service cache
alias flush="dscacheutil -flushcache"

function backup() { cp ${1}{,.bak}; }
function fname() { find . -iname "*$@*"; }
function psgrep() { ps axuf | grep -v grep | grep "$@" -i; }
