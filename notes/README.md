# Notes

Stuff used for note taking.

I'm currently using a directory of text files (as markdown) which has proven
the simplest solution so far. I like it because it's fast and future proof. As
long as a system can read/write text files I can read/edit my notes.

## Editing

On top of that base "system" I use Vim for editing.

## Previewing

#### vim-instant-markdown

The plugin [vim-instant-markdown](https://github.com/suan/vim-instant-markdown)
is great for live previews, though it's got a node dependency so it's not
always available.

#### grip

I haven't used it much but [`grip`](https://github.com/joeyespo/grip) looks
like a decent alternative to `vim-instant-markdown`, though it doesn't have the
live preview feature. It does, however, have a closer-to-github preview.

## Searching & Navigating

Since they're all text files using your favorite command line text-searcher is
free. I like `ag` but `grep` works just as well.

[`terminal_velocity`](https://vhp.github.io/terminal_velocity/) is a really
nice layer on top of all of this that makes creating new notes simple and also
handles basic search across all of your notes at the same time.

## Syncing & Encryption

I'm currently handling syncing across all my machines with Dropbox.

The folder in Dropbox is actually an [`encfs`](https://github.com/vgough/encfs)
container so everything is encrypted. The unencrypted files are mounted to my
local user folder for editing. Biggest downside here is that I need a machine
with `encfs` to read/write my notes which generally isn't a problem for my use
case.
