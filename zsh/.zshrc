HISTFILE=$HOME/.histfile
HISTSIZE=51000
SAVEHIST=21000

# Better path movement
# by default, export WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'
# we take out '/', '.', '-', '[', ']'
export WORDCHARS='*?_~=&;!#$%^(){}<>'


# ------------------------------------------------
# Plugins
# ------------------------------------------------
source ~/.zplug/init.zsh

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"

zplug "plugins/extract", from:oh-my-zsh
zplug "plugins/lein",    from:oh-my-zsh
zplug "plugins/emacs",   from:oh-my-zsh

zplug "rupa/z"
zplug "jocelynmallon/zshmarks"
zplug "hlissner/zsh-autopair"
zplug "lukechilds/zsh-better-npm-completion"
zplug "arzzen/calc.plugin.zsh"
zplug "joepvd/zsh-hints"

if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

zplug load

# bind P and N for Emacs mode
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down


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
fpath=(
    $fpath
    ~/.zsh/functions
    ~/.zsh/functions/**
)
# Render the prompt
autoload -Uz star_prompt
star_prompt "$@"
