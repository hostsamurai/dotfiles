#!/bin/sh

if [ ! -d "$HOME/.zplug" ]; then
  echo "zplug does not exist. Installing it..."
  curl -sL zplug.sh/installer | zsh
else
  zsh -i -c "zplug update --self && zplug update"
fi

exit 0
