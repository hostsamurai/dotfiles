# ------------------------------------------------
# Path modifications
# ------------------------------------------------
function {
  if [[ -d "$HOME/.boot" ]]; then
    path+=("$HOME.boot/bin")
  fi

  if [[ -d "$HOME/.rbenv" ]]; then
    path+=("$HOME.rbenv/bin")
    eval "$(rbenv init -)"
  fi

  if [[ -d "$HOME/.luarocks" ]]; then
    path+="$HOME.luarocks/bin"
    eval "$(luarocks path --lua-version 5.1 --no-bin)"
  fi

  local kernel=`uname`

  if [[ $kernel = "Darwin" ]]; then
    # Make shell aware of homebrew
    eval "$(/opt/homebrew/bin/brew shellenv)"
    # Programs installed by homebrew should appear before the
    # system-provided equivalents.
    export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:/usr/local/bin:$PATH"
    export MANPATH="/opt/homebrew/opt/coreutils/libexec/gnuman:$MANPATH"
    export PKG_CONFIG_PATH="/opt/homebrew/opt/jpeg/bin:$PATH"
  elif [[ $kernel = "Linux" ]]; then
    # Reference the environment variable created by the systemd unit
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
  fi
}
