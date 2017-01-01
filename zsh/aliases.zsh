alias reload!='. ~/.zshrc'

alias la='ls -alG'
alias ack="ack-grep"
alias bu='bundle '
alias brs='bin/rspec -f documentation'
alias fn='find . -name'
alias gb='git branch'
alias gd='git diff'
alias gdn='git diff --name-only'
alias gcmwip='git commit -m "w.i.p."'
alias gdc='git diff --cached'
alias gcm='git commit -m'
alias gcma='git commit --amend'
alias gcom='git checkout master'
alias gclbr='gcom && glom && git br --merged'
alias gdm='git diff master'
alias gmm='git merge master'
alias glom='git pull origin master'
alias gpo='git push origin'
alias gs='git status'
alias hcons='heroku run rails console -a goldbely'
alias hconstg='heroku run rails console -a goldbely-staging'
alias hpg='heroku pg:psql HEROKU_POSTGRESQL_WHITE_URL -a goldbely'
alias pgb='psql goldbely_development'
alias tmuxa='tmux attach || tmux new'

# Recursively delete '.DS_Store' files
alias cleanup="find . -name '*.DS_Store' -type f -ls -delete"

# Flush Directory Service cache
alias flush="dscacheutil -flushcache"

# Start a webserver in the current dir, stolen from @stevenmbone
alias servethis="open http://0.0.0.0:8000 && python -m SimpleHTTPServer"

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop"defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop"defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# Stuff I never really use but cannot delete because of http://xkcd.com/530/
alias stfu="osascript -e 'set volume output muted true'"
alias pumpitup="osascript -e 'set volume 10'"
alias hax="growlnotify -a 'Activity Monitor' 'System error' -m 'WTF R U DOIN'"

function backup() { cp ${1}{,.bak}; }
function fname() { find . -iname "*$@*"; }
function psgrep() { ps axuf | grep -v grep | grep "$@" -i; }
