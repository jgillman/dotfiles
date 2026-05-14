# Dotfiles — AI Context

This is Joel's personal dotfiles repository. It uses a **topic-based structure**
originally forked from [holman/dotfiles](https://github.com/holman/dotfiles).

## Project layout

```
.dotfiles/
  <topic>/           # One directory per tool/topic (git, nvim, tmux, fish, etc.)
    *.zsh            # Auto-loaded by zsh
    *.bash           # Auto-loaded by bash
    *.fish           # Auto-loaded by fish (via config.fish glob)
    *.symlink        # Symlinked to ~/.<name> (e.g. gitconfig.symlink → ~/.gitconfig)
    link.sh          # Custom linker — runs during `./dotfiles.sh install` to
                     # create ~/.config/<topic> symlinks
    config-<topic>/  # Actual config files (linked into ~/.config/<topic>)
    path.{zsh,fish}  # Loaded early (PATH additions); skipped inside tmux/zellij
    aliases.*        # Convenience aliases for the shell
    completion.*     # Loaded last, after compinit
  bin/               # Scripts added to $PATH
  dotfiles.sh        # Install/uninstall script
```

## Installation

```bash
git clone git@github.com:jgillman/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./dotfiles.sh install
```

`install` does two things in order:
1. Symlinks every `*.symlink` file as `~/.<basename>` (e.g. `git/gitconfig.symlink` → `~/.gitconfig`)
2. Runs every `topic/link.sh` file to create `~/.config/<topic>` symlinks (e.g. `nvim/link.sh` → `~/.config/nvim`)

## Key conventions

- **`*.symlink`** → goes to `~/.<name>` (used for old-style dotfiles: `.gitconfig`, `.vimrc`, `.zshrc`)
- **`config-<topic>/`** → linked to `~/.config/<topic>` via `link.sh` (used for XDG-compliant tools: nvim, ghostty, fish, tmux, bat, etc.)
- **`link.sh` pattern** — each script derives its `base_dir` dynamically from the directory name via `basename "$(dirname "${BASH_SOURCE[0]}")"`. The one exception is `brew/link.sh`, which maps `brew/config-homebrew` → `~/.config/homebrew` (Homebrew's XDG config dir name differs from the topic dir name).
- **`.localrc` / `.localrc.fish`** — machine-specific overrides not tracked in git (secrets, machine-local PATHs like bun, LM Studio). Sourced at the end of zshrc / config.fish.
- **`dotfiles.sh`** — safe to re-run; skips existing symlinks. For interactive conflict resolution use the `[s]kip/[o]verwrite/[b]ackup` prompts.

## Shells

- **Primary shell:** fish (`fish/config-fish/config.fish`)
- **Secondary:** zsh (`zsh/zshrc.symlink`)
- **Legacy:** bash (`bash/bashrc.symlink`)

Fish config loads all `*.fish` files found in `$DOTFILES` up to 3 levels deep,
splitting `path.fish` files (run first, skipped inside tmux/zellij) from
everything else.

## Important topics

| Topic | Notes |
|---|---|
| `nvim` | Full LazyVim-based config. `config-nvim/` linked to `~/.config/nvim` |
| `tmux` | Moshi-aware config. `MOSHI_CLIENT` propagated; status bar cleared under Moshi |
| `fish` | Primary shell. Config at `fish/config-fish/` |
| `ghostty` | Primary terminal emulator |
| `git` | gitconfig, gitignore, tigrc all via `.symlink` |
| `brew` | `Brewfile` (personal) + `Brewfile-work`. `config-homebrew/brew.env` linked to `~/.config/homebrew` |
| `starship` | Cross-shell prompt. `starship.toml` linked to `~/.config/starship` |
| `yazi` | Terminal file manager with Dracula theme and plugins |
| `fzf` | Fuzzy finder with custom bin scripts (`fzgit`, `fzbranches`, `fzbrew`, etc.) |

## AI tooling on this machine

### pi (this agent)

- Config: `~/.pi/agent/`
- Local Ollama models registered in `~/.pi/agent/models.json`:
  - `qwen2.5-coder:latest` (4.7 GB, context 32k)
  - `gemma4:latest` (9.6 GB, context 8k)
- Start Ollama before using these: `ollama serve`

### Moshi integration

- `moshi-hook` is installed, paired, and running (`brew services start moshi-hook`)
- Secret store: `file` (`~/.config/moshi/secrets.json`)
- Socket: `~/Library/Application Support/Moshi/moshi-hook.sock`
- Pi bridge extension: `~/.pi/agent/extensions/moshi-hooks.ts`
  - Sends Live Activity updates on every tool call
  - Requests phone/Watch approval for dangerous bash commands (`sudo`, `rm -rf`, `git push --force`, etc.)
- tmux config already propagates `MOSHI_CLIENT` and clears status bar under Moshi

### OpenCode

- Plugin: `.opencode/plugins/moshi-hooks.ts` (first-class `moshi-hook install` target)

## Git submodules

```
cheat/config-cheat/cheatsheets/community  →  https://github.com/cheat/cheatsheets.git
```

## macOS defaults

Run `./macos/set-defaults.sh` on a fresh machine to apply system preferences.
