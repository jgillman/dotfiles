parse_git_branch() {
	echo $(__git_ps1)
}

# PS1="\n$(tput bold)$(tput setaf 6)[\h $(tput setaf 1)\W$(tput setaf 6)] \$(parse_git_branch) \n$(tput sgr0)\$ "
PS1="\n$(tput setaf 6)[\h $(tput setaf 1)\W$(tput setaf 6)] \$(parse_git_branch) \n$(tput sgr0)\$ "
