autoload colors && colors

is_git_repo() {
  [[ -d .git ]] || git rev-parse --git-dir > /dev/null 2>&1
}

git_prompt() {
  if is_git_repo; then
    # in a git repo!
    echo "$(git_dirty)$(need_push)"
  else
    # not in a git repo :(
    echo ""
  fi
}

git_branch() {
  echo "$(git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})"
}

git_wip() {
	local wip=$(git log -1 --oneline 2>/dev/null | awk '{print tolower($2)}' | awk '{gsub(/[^a-z]/, ""); print}')
  if [[ "$wip" == "wip" ]]; then
    echo "%{$fg[red]%}± wip%{$reset_color%}"
  else
    echo ""
  fi
}

git_dirty() {
  local git_status="$(git status --porcelain 2>/dev/null)"
  local exit_status=$?

  if [[ "$git_status" == "" ]]; then
    # clean git status
    echo "on %{$fg[green]%}$(git_prompt_info)%{$reset_color%}"
  else
    # unclean git status
    echo "on %{$fg[red]%}$(git_prompt_info)%{$reset_color%}"
  fi
}

git_prompt_info () {
  local ref="$(git symbolic-ref HEAD 2>/dev/null)" || return
  # echo "on %{$fg[yellow]%}${ref#refs/heads/}%{$reset_color%}"
  echo "${ref#refs/heads/}"
}

unpushed () {
  git cherry -v @{upstream} 2>/dev/null
}

need_push () {
  if [[ "$(unpushed)" == "" ]]
  then
    echo ""
  else
    echo " with %{$fg[magenta]%}unpushed%{$reset_color%}"
  fi
}

host_prompt() {
  echo "%{$fg[yellow]%}$(hostname -s)%{$reset_color%}"
}

directory_name(){
  echo "%{$fg[cyan]%}%1/%\/%{$reset_color%}"
}

set_prompt () {
  export PROMPT=$'\n$(host_prompt) in $(directory_name) $(git_prompt)\n$(git_wip)› '
  export RPROMPT=$'%{$fg_bold[green]%}%~ @ %*%{$reset_color%}'
}

precmd() {
  title "zsh" "%m" "%55<...<%~"
  set_prompt
}
