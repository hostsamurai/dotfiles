HISTFILE=$HOME/.histfile
HISTSIZE=51000
SAVEHIST=21000

zstyle :compinstall filename "/home/$USER/.zshrc"

# Better path movement
# by default, export WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'
# we take out '/', '.', '-', '[', ']'
export WORDCHARS='*?_~=&;!#$%^(){}<>'


# ------------------------------------------------
# Plugins
# ------------------------------------------------
# load zgen
source "${HOME}/.zgen/zgen.zsh"

# The autopair plugin needs this or it won't work with prezto.
# See https://github.com/hlissner/zsh-autopair/issues/6
AUTOPAIR_INHIBIT_INIT=1

# check if there's no init script
if ! zgen saved; then
  echo "Creating a zgen save"

  # prezto options
  zgen prezto editor key-bindings "emacs"

  # prezto and modules
  zgen prezto
  zgen prezto completion
  zgen prezto directory
  zgen prezto history
  zgen prezto archive
  zgen prezto git
  zgen prezto command-not-found
  zgen prezto spectrum
  zgen prezto syntax-highlighting
  zgen prezto history-substring-search

  # plugins
  zgen load rupa/z
  zgen load jocelynmallon/zshmarks
  zgen load hlissner/zsh-autopair 'autopair.zsh'
  zgen load lukechilds/zsh-better-npm-completion

  zgen save
fi

zstyle ':prezto:module:syntax-highlighting' color 'yes'
zstyle ':prezto:module:syntax-highlighting' highlighters \
       'main' \
       'brackets' \
       'pattern' \
       'cursor' \
       'root'
zstyle ':prezto:module:history-substring-search' color 'yes'

# bind P and N for Emacs mode
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# manually start the autopair plugin
autopair-init


# ------------------------------------------------
# Options
# ------------------------------------------------
setopt clobber


# ------------------------------------------------
# Aliases
# ------------------------------------------------
alias ls='ls -hF --color=auto'
alias lr='ls -R'   # recursive ls
alias ll='ls -la'
alias la='ls -A'
alias lx='ll -BX'  # sort by extension
alias lz='ll -rS'  # sort by size
alias lt='ll -rt'  # sort by date
alias less='less -R'

alias -g L='| less'
alias -g M='| more'


# ------------------------------------------------
# Custom functions
# ------------------------------------------------
# Render the prompt
autoload -Uz star_prompt
star_prompt "$@"
