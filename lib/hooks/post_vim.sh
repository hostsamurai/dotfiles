#!/bin/sh

if [ ! -e ./vim/.vim/autoload/plug.vim ]; then
  echo 'Installing packer...'
  git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/opt/packer.nvim
  vim -X -n +PackerInstall +qall > /dev/null
  echo 'Done installing vim plugins.'
else
  echo 'Updating plugins...'
  vim -X -n +PackerSync +PackerCompile +qall > /dev/null
  echo 'Done updating vim plugins.'
fi
