autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

git_branch() {
  echo $(/usr/bin/git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_wip() {
	wip=$(/usr/bin/git log -1 --oneline 2>/dev/null | awk '{print tolower($2)}' | awk '{gsub(/[^a-z]/, ""); print}')
  if [[ $wip == "wip" ]]
  then
    echo "%{$fg[red]%}± wip%{$reset_color%}"
  else
    echo ""
  fi
  unset wip
}

git_dirty() {
  st=$(/usr/bin/git status 2>/dev/null | tail -n 1)
  if [[ $st == "" ]]
  then
    echo ""
  else
    if [[ $st == "nothing to commit, working directory clean" ]]
    then
      echo "on %{$fg[green]%}$(git_prompt_info)%{$reset_color%}"
    else
      echo "on %{$fg[red]%}$(git_prompt_info)%{$reset_color%}"
    fi
  fi
  unset st
}

git_prompt_info () {
 ref=$(/usr/bin/git symbolic-ref HEAD 2>/dev/null) || return
# echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
 echo "${ref#refs/heads/}"
 unset ref
}

unpushed () {
  /usr/bin/git cherry -v @{upstream} 2>/dev/null
}

need_push () {
  if [[ $(unpushed) == "" ]]
  then
    echo " "
  else
    echo " with %{$fg[magenta]%}unpushed%{$reset_color%} "
  fi
}

rb_prompt(){
  if $(which rbenv &> /dev/null)
  then
    echo "%{$fg[yellow]%}$(rbenv version | awk '{print $1}')%{$reset_color%}"
  else
    echo "%m"
  fi
}

directory_name(){
  echo "%{$fg[cyan]%}%1/%\/%{$reset_color%}"
}

set_prompt () {
  export PROMPT=$'\n$(rb_prompt) in $(directory_name) $(git_dirty)$(need_push)\n$(git_wip)› '
  export RPROMPT=$'%{$fg_bold[green]%}%~ @ %*%{$reset_color%}'
}

precmd() {
  title "zsh" "%m" "%55<...<%~"
  set_prompt
}
