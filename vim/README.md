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

When starting up vim for the first time there may be a handful of errors as it will try to use plugins that haven't been installed yet. This is normal and doesn't realy hurt anything. Just hit 'enter' to dismiss them one by one.
