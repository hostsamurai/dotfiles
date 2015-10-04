## Overview

As you would have guessed, this is my personal configuration setup. It includes
configuration for [zsh](http://www.zsh.org/), [git](http://git-scm.com/) and
[mercurial](), [tmux](https://tmux.github.io/), [vim](http://www.vim.org) and
[spacemacs](https://github.com/syl20bnr/spacemacs). It attempts to be
cross-platform, meaning that this should all work on OS X and Linux without any
problems provided that a few prerequisites are in place.

## Prerequisites

The `Makefile` expects GNU `sed` and `stow` to be installed. You probably want
to install these dependencies with [Homebrew](http://brew.sh/) if you're on OS
X. The following commands will install them:

```shell
brew install stow
brew install gnu-sed --with-default-names
```

Chances are that the correct version of `sed` will already be installed on
whatever flavor of Linux you're running. Use your distro's package manager to
install `stow` if it isn't already.

## Installation

Clone the repo to a directory in your home directory with

```shell
git clone --recursive http://github.com/hostsamurai/dotfiles ~/dotfiles
```

This will pull down all the configurations plus any submodule dependencies and
sync them to their latest versions. Run `make all` to symlink all dotfiles or
see the output of `make help` for a list of specific configurations recipes that
you can install.

## Caveat Emptor

It's a good idea to back up your own dotfiles before attempting to stow any
configration files from this repo. Also, note that the VCS recipe will prompt
you for a username and email so it can update the appropriate files with them.
It substitutes those values by running a `sed` command, so beware. The
[beslobber](http://github.com/hostsamurai/dotfiles/tree/master/lib/beslobber)
git filter prevents your actual username and email from being committed into
source control.
