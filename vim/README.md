# vim

My editor of choice.

I use [vundle][] to manage my plugins. See below for setting that up:

[vundle]: https://github.com/VundleVim/Vundle.vim

## Install

```sh
# Change to the dotfile dir
cd ~/.dotfiles

# Initialize git submodules
rake git:init

# Install plugins and quit
vim +PluginInstall +qall
```

## Local config

Local configurations can be set in `~/.vimrc.local` which is source at the end of `.vimrc`.
