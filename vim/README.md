# vim

My editor of choice.

I use [vim-plug][] to manage my plugins. See below for setting that up.

The [fzf.vim][] plugin needs fzf to be installed. It shouldn't try to load if it doesn't exist, but if you want to use it check the [fzf readme][] for install instructions.

[vim-plug]: https://github.com/junegunn/vim-plug
[fzf.vim]: https://github.com/junegunn/fzf.vim
[fzf readme]: https://github.com/jgillman/dotfiles/tree/master/fzf

## Install

```sh
# Install plugins and quit
vim +PlugInstall +qall
```

## Local config

Local configurations can be set in `~/.vimrc.local` which is source at the end of `.vimrc`.
