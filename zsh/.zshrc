HISTFILE=$HOME/.histfile
HISTSIZE=51000
SAVEHIST=21000

zstyle :compinstall filename "/home/$USER/.zshrc"

# Better path movement
# by default, export WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'
# we take out '/', '.', '-', '[', ']'
export WORDCHARS='*?_~=&;!#$%^(){}<>'


# ------------------------------------------------
# Path modifications
# ------------------------------------------------
if [[ -d "$HOME/.rbenv" ]]; then
  path+=("$HOME/.rbenv/bin")
  export PATH
  eval "$(rbenv init -)"
fi


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
fpath=(
  $fpath
  ~/.zsh/functions
  ~/.zsh/functions/**
)


# ------------------------------------------------
# Plugins
# ------------------------------------------------
# load zgen
source "${HOME}/zgen/zgen.zsh"

# check if there's no init script
if ! zgen saved; then
  echo "Creating a zgen save"

  # prezto options
  zgen prezto editor key-bindings "emacs"

  # prezto and modules
  zgen prezto
  zgen prezto utility
  zgen prezto completion
  zgen prezto history
  zgen prezto archive
  zgen prezto git
  zgen prezto command-not-found
  zgen prezto syntax-highlighting
  zgen prezto history-substring-search
  zgen prezto spectrum

  # plugins
  zgen load rupa/z
  zgen load tarruda/zsh-autosuggestions
  zgen load jocelynmallon/zshmarks

  zgen save
fi

# Enable autosuggestions automatically.
zle-line-init() {
  zle autosuggest-start
}
zle -N zle-line-init

# prevent erasing the previous line in the shell when
# hitting TAB due to the editor plugin not playing
# nice with autosuggestions
bindkey "^I" expand-or-complete

# bind P and N for EMACS mode
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down


# Render the prompt
autoload -Uz star_prompt
star_prompt "$@"
