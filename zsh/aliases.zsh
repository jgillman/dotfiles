alias reload!='. ~/.zshrc'

alias ack="ack-grep"
alias bu='bundle '
alias brs='bin/rspec -f documentation'
alias brsx='brs $(git status | grep "_spec\.rb" | grep "modified:" | cut -b 14- )'
alias fn='find . -name'
alias gdn='git diff --name-only'
alias gdnm='git diff --name-only master'
alias grs='git restore --staged'
alias grm="git reset `git log --oneline master | head -n 1 | awk -F' ' '{print $1}'`"
alias grbm="git rebase master"
alias hcons='heroku run rails c -e DISABLE_DATADOG_AGENT=true --app goldbely'
alias la='ls -alG'
alias tmuxa='tmux attach || tmux new'
alias pgsyncmd='pgsync cart_items,orders,suborders,line_items,accounts,products,mdash_accounts,shippers,merchants,shipping_labels,shipping_schedules,product_shipping_schedules,pick_up_locations,pick_up_schedules,pick_up_schedule_products,shipping_schedule_ship_date_scorecards,fulfillment_adjustments,fulfillment_adjustment_suborders,reshipments,bloatie_submissions --preserve'
alias vgs='vim `gs -s | sed "s/.. \(.*\)/\1/"`'

# Flush Directory Service cache
alias flush="dscacheutil -flushcache"

# Start a webserver in the current dir, stolen from @stevenmbone
alias servethis="open http://0.0.0.0:8000 && python -m SimpleHTTPServer"

function backup() { cp ${1}{,.bak}; }
function fname() { find . -iname "*$@*"; }
function psgrep() { ps axuf | grep -v grep | grep "$@" -i; }
