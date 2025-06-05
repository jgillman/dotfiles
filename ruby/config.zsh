if _has rbenv; then
  # rbenv
  export RBENV_ROOT=/opt/homebrew/opt/rbenv
  export PATH=$RBENV_ROOT/bin:$PATH
  eval "$(rbenv init -)"
fi

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
