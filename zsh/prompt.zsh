autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

git_branch() {
  echo $(/usr/bin/git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_wip() {
	wip=$(/usr/bin/git log -1 --oneline 2>/dev/null | awk '{print tolower($2)}' | awk '{gsub(/[^a-z]/, ""); print}')
  if [[ $wip == "wip" ]]; then
    echo "%{$fg[red]%}± wip%{$reset_color%}"
  else
    echo ""
  fi
  unset wip
}

git_dirty() {
  local git_status="$(/usr/bin/git status --porcelain 2>/dev/null)"
  local exit_status=$?

  if [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1; then
    # in a git repo!
    if [[ "$git_status" == "" ]]; then
      # clean git status
      echo "on %{$fg[green]%}$(git_prompt_info)%{$reset_color%}"
    else
      # unclean git status
      echo "on %{$fg[red]%}$(git_prompt_info)%{$reset_color%}"
    fi
  else
    # we're not in a git repo
    echo ""
  fi
}

git_prompt_info () {
  ref=$(/usr/bin/git symbolic-ref HEAD 2>/dev/null) || return
  # echo "on %{$fg[yellow]%}${ref#refs/heads/}%{$reset_color%}"
  echo "${ref#refs/heads/}"
  unset ref
}

unpushed () {
  /usr/bin/git cherry -v @{upstream} 2>/dev/null
}

need_push () {
  if [[ $(unpushed) == "" ]]
  then
    echo ""
  else
    echo " with %{$fg[magenta]%}unpushed%{$reset_color%}"
  fi
}

rb_prompt(){
  if $(which rbenv &> /dev/null); then
    echo "%{$fg[yellow]%}$(rbenv version | awk '{print $1}')%{$reset_color%}"
  else
    echo "%m"
  fi
}

host_prompt() {
  echo "%{$fg[yellow]%}$(hostname -s)%{$reset_color%}"
}

directory_name(){
  echo "%{$fg[cyan]%}%1/%\/%{$reset_color%}"
}

set_prompt () {
  export PROMPT=$'\n$(host_prompt) in $(directory_name) $(git_dirty)$(need_push)\n$(git_wip)› '
  export RPROMPT=$'%{$fg_bold[green]%}%~ @ %*%{$reset_color%}'
}

precmd() {
  title "zsh" "%m" "%55<...<%~"
  set_prompt
}
