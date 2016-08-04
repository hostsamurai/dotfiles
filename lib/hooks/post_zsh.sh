#!/bin/sh

if [ ! -d "$HOME/.fzf" ]; then
  echo "Installing fzf..."
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
else
  echo "Updating fzf..."
  cd ~/.fzf && git pull && ./install --all
fi

if [ ! -d "$HOME/.zplug" ]; then
  echo "zplug does not exist. Installing it..."
  curl -sL zplug.sh/installer | zsh
else
  zsh -i -c "zplug update --self && zplug update"
fi

exit 0
