alias b='bundle exec'
alias brs='b rspec'
alias migrateall='b rake db:migrate db:test:prepare'
alias pbm='git pull; bundle; migrateall;'

alias railsc='GOLDBELY_ADMIN=true GOLDBELY_PUBLIC=true RACK_ENV=development rails console'
alias prodc='heroku run console --app goldbely'
alias stagc='heroku run console --app goldbely-staging'

