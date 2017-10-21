load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
    nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
    nvm use --silent
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

# ------------------------------------------------
# Path modifications
# ------------------------------------------------
function {
  export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

  if [[ -d "$HOME/.boot" ]]; then
    path+=("$HOME/.boot/bin")
  fi

  if [[ -d "$HOME/.rbenv" ]]; then
    path+=("$HOME/.rbenv/bin")
    export PATH
    eval "$(rbenv init -)"
  fi

  # NVM config stuff
  export NVM_DIR="/home/lou/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" --no-use  # This loads nvm

  autoload -U add-zsh-hook
  add-zsh-hook chpwd load-nvmrc
  load-nvmrc

  local kernel=`uname`

  if [[ kernel = "Darwin" ]]; then
    # Programs installed by homebrew should appear before the
    # system-provided equivalents.
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:$PATH"
    export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
  elif [[ kernel = "Linux" ]]; then
    # Reference the environment variable created by the systemd unit
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
    # Optimization for NVIDIA card
    export __GL_THREADED_OPTIMISATIONS=1
  fi
}
