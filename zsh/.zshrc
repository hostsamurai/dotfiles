HISTFILE=$HOME/.histfile
HISTSIZE=51000
SAVEHIST=21000

# Source completions first to keep any plugins that depend
# on them from complaining.
source ~/.zsh/completion.zsh

# Better path movement
# by default, export WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'
# we take out '/', '.', '-', '[', ']'
export WORDCHARS='*?_~=&;!#$%^(){}<>'


# ------------------------------------------------
# Plugins
# ------------------------------------------------

if [[ `uname` = "Darwin" ]]; then
  export ZPLUG_HOME=/usr/local/opt/zplug
else
  export ZPLUG_HOME=~/.zplug
fi

source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search"

zplug "plugins/extract", from:oh-my-zsh
zplug "plugins/lein",    from:oh-my-zsh

zplug "rupa/z", use:z.sh
zplug "Tarrasch/zsh-bd", use:bd.zsh
zplug "b4b4r07/enhancd", use:init.sh
zplug "jocelynmallon/zshmarks"
zplug "hlissner/zsh-autopair", defer:2
zplug "paulirish/git-open", as:command
zplug "alexdavid/git-branch-status", as:command
zplug "lukechilds/zsh-better-npm-completion"
zplug "arzzen/calc.plugin.zsh"
zplug "joepvd/zsh-hints"

zplug "zplug/zplug", hook-build:'zplug --self-manage'

if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

if zplug check b4b4r07/enhancd; then
  export ENHANCD_FILTER=fzf-tmux:fzf
fi

zplug load

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# bind P and N for Emacs mode
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down


# ------------------------------------------------
# Options
# ------------------------------------------------

# Use some of Prezto's settings for...

# History
setopt BANG_HIST              # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY       # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY     # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY          # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS       # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS   # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS      # Do not display a previously found event.
setopt HIST_IGNORE_SPACE      # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS      # Do not write a duplicate event to the history file.
setopt HIST_VERIFY            # Do not execute immediately upon history expansion.
setopt HIST_BEEP              # Beep when accessing non-existent history.

# Jobs
setopt LONG_LIST_JOBS # List jobs in the long format by default.
setopt AUTO_RESUME    # Attempt to resume existing job before creating a new process.
setopt NOTIFY         # Report status of background jobs immediately.
unsetopt BG_NICE      # Don't run all background jobs at a lower priority.
unsetopt HUP          # Don't kill jobs on shell exit.
unsetopt CHECK_JOBS   # Don't report on jobs when shell exit.


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

alias xl='exa -la'
alias xr='xl -R'           # recursive exa
alias xs='xl -s=size'      # sort by modified time
alias xt='xl -s=modified'  # sort by modified time
alias xx='xl -s=extension' # sort by extension

alias diff='colordiff'
alias grep='grep --color=auto'

alias -g L='| less'
alias -g M='| more'

# apply aliases when running commands with sudo
alias sudo='sudo '

if [ -d ~/.atom -a -d ~/.proton.d ]; then
  alias atomm='ATOM_HOME=~/.atom-backup atom'
  alias atomd='ATOM_HOME=~/.atom-backup atom --dev'
  alias proton='ATOM_HOME=~/.proton.d atom'
  alias protond='ATOM_HOME=~/.proton.d atom --dev'
fi

if [[ `uname` == 'Linux' ]]; then
  alias pls='pacman -Qen'
  alias plsaur='pacman -Qm'
  alias pS='sudo pacman -S '
  alias psyu='sudo pacman -Syu'
  alias pps='sudo powerpill -S '
  alias ppsyu='sudo powerpill -Syu'
  alias ppss='powerpill -Ss'
fi


# Render the prompt
autoload -Uz star_prompt
star_prompt "$@"

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
  source /etc/profile.d/vte.sh
fi
