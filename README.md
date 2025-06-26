# jgillman's special dotfiles

## Shoutout

All of this was originally forked from and later inspired by [holman's
dotfiles](https://github.com/holman/dotfiles). While the original Ruby
dependencies have been removed the main strategy of using "topic" folders is
still here which, imo, is the best part.

## dotfiles

Dotfiles are essentially what makes your environment *yours*. All your unique
little tweaks and settings that make your computer completely unusable and
foreign to others. I had originally kept all my dotfiles in Dropbox which
worked really nicely for a long time. Two big issues I had with my Dropbox
setup is that 1) I would manually have to symlink new files/folders and 2) I
couldn't use them on remote development machines (where I often work).

Also, to steal directly from [holman](https://github.com/holman):

> I was a little tired of having long alias files and everything strewn about
> (which is extremely common on other dotfiles projects, too). That led to this
> project being much more topic-centric. I realized I could split a lot of
> things up into the main areas I used (Ruby, git, system libraries, and so on),
> so I structured the project accordingly.
>
> If you're interested in the philosophy behind why projects like these are
> awesome, you might want to [read my post on the
> subject](http://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/).

## install

- `git clone git@github.com:jgillman/dotfiles.git ~/.dotfiles`
- `cd ~/.dotfiles`
- `./dotfiles.sh install`

The install task will symlink the appropriate files in `.dotfiles` to your home
directory. Everything is configured and tweaked within `~/.dotfiles`, though.

## topical

Everything's built around topic areas. If you're adding a new area to your
dotfiles — say, "Java" — you can simply add a `java` directory and put files in
there. Anything with an extension of `.bash`, `.zsh`, or `.fish` will get
automatically included into that respective shell. Anything with an extension
of `.symlink` will get symlinked without extension into `$HOME`. Files that
need custom linking (for example, into `~/.config/`) can be handled through
`link.sh` files within each topic.

## components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/\*.symlink**: Any files ending in `*.symlink` get symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `rake install`.
- **topic/\*.completion.sh**: Any files ending in `completion.sh` get loaded
  last so that they get loaded after we set up zsh autocomplete functions.
