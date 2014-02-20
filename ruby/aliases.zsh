alias b='bundle exec'
alias brs='b rspec'
alias migrateall='b rake db:migrate db:test:prepare'
alias pbm='git pull; bundle; migrateall;'

alias prodc='heroku run console --app goldbely'
alias stagc='heroku run console --app goldbely-staging'

