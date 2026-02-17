# Make sure we're using UTF8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# Set the default editor
if _has nvim; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

if _has bat; then
  export MANPAGER='sh -c "col -bx | bat -plman"'
  export MANROFFOPT="-c"
else
# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"
fi
# Highlight section titles in manual pages
export LESS_TERMCAP_md="$ORANGE"

export LESS=-RFX
