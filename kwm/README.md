# kwm tiling window mamager

From https://github.com/koekeishiya/kwm

## Install

```
brew install koekeishiya/khd/khd
brew install koekeishiya/kwm/kwm
```

## Start services

```
brew services start khd
brew services start kwm
```

This will start the services and set them to relaunch on login.

## Usage

Keyboard shortcuts are controlled by `khd`, the actual window moving stuff is handled by `kwm`.

As a convention, `Cmd + Alt` is used for moving *focus* and `Ctrl + Alt` is used for moving windows.

So if `Cmd + Alt + h` moves the focus west (i.e. left) that means that `Ctrl + Alt + h` will move the currently focused window west.
