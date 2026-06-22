# Vim files

My portable Vim configuration for macOS, Linux, and Windows.

This repository works independently of my dotfiles and chezmoi setup. Clone it
on a server, personal computer, or work computer and run the installer for that
platform. It can be cloned anywhere.

The installer connects the repository to Vim's native user runtime directory
and startup files. It does not copy the configuration, so `git pull` updates it
in place. Existing unrelated Vim configuration is never overwritten.

## Requirements

- Vim 8 or newer
- Git
- [fzf](https://github.com/junegunn/fzf), optionally, for fuzzy-finder mappings

The configuration still starts normally when `fzf` is unavailable; only its
mappings are omitted.

## macOS and Linux

Clone the repository and run the POSIX installer:

```sh
git clone https://github.com/jakubstefanski/vimfiles.git ~/vimfiles
~/vimfiles/install.sh
```

This creates `~/.vim`, `~/.vimrc`, and `~/.gvimrc` symlinks. Running the
installer again is safe.

## Windows

In PowerShell:

```powershell
git clone https://github.com/jakubstefanski/vimfiles.git "$HOME\Projects\vimfiles"
& "$HOME\Projects\vimfiles\install.ps1"
```

This creates Vim's `~/vimfiles` runtime directory as a directory junction and
creates `~/_vimrc` and `~/_gvimrc` startup wrappers. It does not require
administrator privileges on a normal local NTFS volume.

## Updating

Run:

```sh
git -C ~/vimfiles pull --ff-only
```

Use the actual clone path if you chose another location. On Windows, the same
command works in PowerShell.

## Existing configuration

The installers stop when a destination already exists and is not managed by
this repository. Move or merge the existing files yourself, then run the
installer again. This is intentional: installation must not silently destroy a
machine's existing Vim setup.

When this repository is installed by chezmoi, chezmoi manages the clone and
the platform-specific wrapper files.
