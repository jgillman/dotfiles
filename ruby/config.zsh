program_exists() {
  hash $1 2>/dev/null
}

if program_exists rbenv
then
  eval "$(rbenv init -)"
fi

unset program_exists

