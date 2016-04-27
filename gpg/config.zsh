export GPGKEY=13104968

# Use gpg-agent if it's available
if hash gpg-agent 2>/dev/null; then

  function is_gpg_agent_running() {
    kill -0 $(cut -d: -f 2 ${HOME}/.gpg-agent-info) 2>/dev/null
  }

  if test -f ${HOME}/.gpg-agent-info && is_gpg_agent_running; then
    GPG_AGENT_INFO=$(cat "${HOME}/.gpg-agent-info" | cut -c 16-)
  else
    # Start a gpg-agent session
    eval $(gpg-agent --daemon --no-grab --write-env-file ${HOME}/.gpg-agent-info)
  fi

  export GPG_TTY=$(tty)
  export GPG_AGENT_INFO
fi
