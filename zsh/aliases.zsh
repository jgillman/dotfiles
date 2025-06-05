alias reload!='. ~/.zshrc'

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias cd.="cd ~/.dotfiles"
alias la="ls -A"
alias ll="ls -lAhF"
alias l="ll"
alias :q="exit"

if _has bat; then
  alias cat="bat"
fi

alias weather=ansiweather
alias clock="tty-clock -c -t"
alias du="ncdu --color dark -rr"
alias music="ncmpcpp"
alias reddit="rtv"
alias youtube="mpsyt"

# Recursively delete '.DS_Store' files
alias cleanup="find . -name '*.DS_Store' -type f -ls -delete"

# Flush Directory Service cache
alias flush="dscacheutil -flushcache"

# Start a webserver in the current dir, stolen from @stevenmbone
alias servethis="open http://0.0.0.0:8000 && python -m SimpleHTTPServer"

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop"defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop"defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

function backup() { cp ${1}{,.bak}; }
function fname() { find . -iname "*$@*"; }
function psgrep() { ps axuf | grep -v grep | grep "$@" -i; }
