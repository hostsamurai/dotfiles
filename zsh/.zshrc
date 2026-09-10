unset HISTFILE  # zhist owns persistence now
HISTSIZE=100000 # In-memory events for up- and down-arrow events and ! expansion
SAVEHIST=1      # Never write a history file 

autoload -Uz compinit && compinit -u

setopt extendedglob

# Source completions first to keep any plugins that depend
# on them from complaining.
source ~/.zsh/completion.zsh

# Better path movement
# by default, export WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'
# we take out '/', '.', '-', '[', ']'
export WORDCHARS='*?_~=&;!#$%^(){}<>='
# Set bat theme
export BAT_THEME='Monokai Extended Origin'

# Modules to load
autoload -z edit-command-line
zle -N edit-command-line

# bind P and N for Emacs mode
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
bindkey -M viins '^P' history-substring-search-up
bindkey -M viins '^N' history-substring-search-down
bindkey -M viins '^X^E' edit-command-line

# Edit the current command line in $EDITOR
bindkey '^X^E' edit-command-line

bindkey '^U' backward-kill-line

# Use vim key bindings
bindkey -v

# Set editor to Neovim if it is available
export EDITOR=nvim

# Hooks
autoload -U add-zsh-hook
source ~/.zsh/hooks/headroom-hook
add-zsh-hook chpwd setup-headroom-and-claude-alias

# ------------------------------------------------
# Plugins
# ------------------------------------------------

if [[ `uname` = "Darwin" ]]; then
  export ZINIT_HOME=/opt/homebrew/opt/zinit.zsh
else
  export ZINIT_HOME=/usr/share/zinit/zinit.zsh
fi

source $ZINIT_HOME
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zi snippet OMZP::extract
zi snippet OMZP::lein/_lein

# better shell history; depends on zhist binary  
zi ice from"gh-r" as"program"
zi light overflowy/zhist

# predictive autosuggestions; depends on deja binary 
zi ice wait lucid depth=1 
zi light Giammarco-Ferranti/deja 

zi as"null" wait"2" lucid for \
  zsh-users/zsh-syntax-highlighting  \
  dim-an/cod \
  zsh-users/zsh-history-substring-search \
  lukechilds/zsh-better-npm-completion \
  arzzen/calc.plugin.zsh \
  joepvd/zsh-hints \
  jocelynmallon/zshmarks \
  hlissner/zsh-autopair  \
  zsh-users/zsh-completions

zi ice src"z.sh"
zi light rupa/z

zi ice src"bd.zsh"
zi light Tarrasch/zsh-bd

zi ice as"command"
zi light paulirish/git-open

zi ice as"command"
zi light alexdavid/git-branch-status

if [[ `uname` == 'Linux' ]]; then
  . /usr/share/fzf/key-bindings.zsh
  . /etc/profile.d/fzf-extras.zsh
else
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi

export ENHANCD_FILTER=fzf-tmux:fzf

if type "fasd" > /dev/null; then
  eval "$(fasd --init auto)"
fi

export GTAGSCONF=/usr/share/gtags/gtags.conf
export GTAGSLABEL=pygments


# ------------------------------------------------
# Options
# ------------------------------------------------

# History
setopt BANG_HIST              # Treat the '!' character specially during expansion.
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

alias du='du -h --max-depth=1' # print directories by size

alias less='less -R'

alias xl='eza -la --icons=always'
alias xr='xl -R'           # recursive eza
alias xs='xl -s=size'      # sort by size
alias xt='xl -s=modified'  # sort by modified time
alias xx='xl -s=extension' # sort by extension

alias a='fasd -a'     # any
alias s='fasd -si'    # show / search / select
alias d='fasd -d'     # directory
alias f='fasd -f'     # file
alias sd='fasd -sid'  # interactive directory selection
alias sf='fasd -sif'  # interactive file selection
alias zz='fasd -d -i' # cd with interactive selection

alias diff='colordiff'
alias grep='grep --color=auto'
alias rg='rg --hyperlink-format=kitty'

# tmux-spotlight standalone launch
alias tsp='/home/lou/.tmux/plugins/tmux-spotlight-ddf5f56a664d/scripts/switcher.sh'

alias -g L='| less'
alias -g M='| more'

alias vim='nvim'

# apply aliases when running commands with sudo
alias sudo='sudo '

if [[ `uname` == 'Linux' ]]; then
  alias pqi='pacman -Qi'
  alias pls='pacman -Qen'
  alias plsaur='pacman -Qm'
  alias pql='pacman -Ql'
  alias prd='sudo pacman -Rd'
  alias pS='sudo pacman -S '
  alias psyu='sudo pacman -Syu'
  alias pps='sudo pacman -S '
  alias ppsyu='sudo pacman -Syu'
  alias ppss='pacman -Ss'
  alias pppss='paru -S --aur'

  alias restart-network='sudo systemctl restart systemd-resolved systemd-networkd.service'

  alias vpn.up='sudo wg-quick up /etc/wireguard/wg0.conf'
  alias vpn.down='sudo wg-quick down /etc/wireguard/wg0.conf'

  # free swap
  alias freeswap='sudo swapoff -a; sudo swapon -a'
fi

alias cljs='shadow-cljs'
alias cljs-new='bunx create-cljs-project'
alias cljs-build='cljs compile app'
alias cljs-watch='cljs watch app'
alias cljs-repl='cljs cljs-repl app'
alias cljs-nrepl='cljs node-repl app'
alias cljs-release='cljs release app'

# ------------------------------------------------
# Autoloaded Functions
# ------------------------------------------------

autoload -Uz faviconify
autoload -Uz herdr-lazy

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
  source /etc/profile.d/vte.sh
fi

# ------------------------------------------------
# Toolchain
# ------------------------------------------------

# mise 
eval "$(~/.local/bin/mise activate zsh)"

# fnox 
if [ -f ~/.config/fnox/age.txt ]; then 
  export FNOX_AGE_KEY=$(cat ~/.config/fnox/age.txt | grep "AGE-SECRET-KEY")
fi

# jj-waltz 
eval "$(jw shell init zsh)"

# Helix and Steel
export PATH="$PATH:$HOME.cargo/bin:$HOME.steel/bin"

# Roswell (Common Lisp)
[ -d "$HOME/.roswell" ] && PATH="$PATH:$HOME.roswell/bin"

# bbin (babashka)
[ -d "$HOME/.local/bin" ] && PATH="$PATH:$HOME.local/bin" 

eval "$(zhist init)"
eval "$(deja init zsh)"

# Work-specific .zshrc
[ -f ~/.zshrc_work ] && source ~/.zshrc_work

# starship prompt
eval "$(starship init zsh)"
