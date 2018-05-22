# ChunkWM tiling window manager

From https://github.com/koekeishiya/chunkwm

- [chunkwm][] is responsible for the actual window management
- [skhd][] watches for hotkeys and sends commands to chunkwm

## Install

```
brew tap crisidev/homebrew-chunkwm
brew install chunkwm
brew install koekeishiya/formulae/skhd
```

## Start services

```
brew services start skhd
brew services start chunkwm
```

This will start the services and set them to relaunch on login.

## Usage

Keyboard shortcuts are controlled by `skhd`, the actual window moving stuff is handled by `chunkwm`.

As a convention, `Cmd + Alt` is used for moving *focus* and `Ctrl + Alt` is used for moving windows.

So if `Cmd + Alt + h` moves the focus west (i.e. left) that means that `Ctrl + Alt + h` will move the currently focused window west.

[chunkwm]: https://github.com/koekeishiya/chunkwm
[skhd]: https://github.com/koekeishiya/skhd
