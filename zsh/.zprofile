# ------------------------------------------------
# Path modifications
# ------------------------------------------------
function () {
  if [[ -d "$HOME/.boot" ]]; then
    path+=("$HOME/.boot/bin")
  fi

  if [[ -d "$HOME/.rbenv" ]]; then
    path+=("$HOME/.rbenv/bin")
    export PATH
    eval "$(rbenv init -)"
  fi

  export NVM_DIR="/home/lou/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

  local kernel=`uname`

  if [[ kernel = "Darwin" ]]; then
    # Programs installed by homebrew should appear before the
    # system-provided equivalents.
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:$PATH"
    export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
  elif [[ kernel = "Linux" ]]; then
    # Reference the environment variable created by the systemd unit
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
  fi
}
