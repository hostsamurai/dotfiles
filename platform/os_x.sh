#!/bin/sh

# install Homebrew if it doesn't exist
if [ -z $(command -v brew >/dev/null 2>&1) ]; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew bundle ./osx/Brewfile
