#!/bin/sh

if [ ! -e ./vim/.vim/autoload/plug.vim ]; then
  echo 'Installing vim-plug...'
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  vim -X -n +PlugInstall +qall > /dev/null
  echo 'Done installing vim plugins.'
else
  echo 'Updating vim-plug and plugins...'
  vim -X -n +PlugUpgrade +PlugUpdate +qall > /dev/null
  echo 'Done updating vim plugins.'
fi
