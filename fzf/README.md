# fzf

> [fzf][] is a general-purpose command-line fuzzy finder.

[fzf]: https://github.com/junegunn/fzf

I sometimes use it on the command line, but mostly use it with Vim.

## Install

The latest install instructions [are in the fzf repo](https://github.com/junegunn/fzf#installation), but below are my version for my config.

### macOS with Homebrew

```
brew install fzf
$(brew --prefix)/opt/fzf/install \
  --key-bindings \
  --completion \
  --no-update-rc
```

### via Git (for Ubuntu boxes)

```
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install \
  --key-bindings \
  --completion \
  --no-update-rc
```
