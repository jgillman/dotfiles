# Half-assed bashrc for basic getting around if zsh isn't available yet

# If not running interactively, don't do anything
[ -z "$PS1" ] && return


# shortcut to this dotfiles path is $BASH
export BASH=$HOME/.dotfiles

# set default editor
export VISUAL=vim
export EDITOR=vim

# source every .bash file in bash/
for config_file in $BASH/bash/*.bash
do
	source $config_file
done

# source every completion files
for completion_file in $BASH/**/completion.sh
do
	source $completion_file
done

# use .localrc for SUPER SECRET CRAP that you don't
# want in your public, versioned repo.
if [[ -a ~/.localrc ]]
then
  source ~/.localrc
fi
