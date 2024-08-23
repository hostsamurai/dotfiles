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

  # proto
  export PROTO_HOME="$HOME/.proto"
  export PATH="$PROTO_HOME/shims:$PROTO_HOME/bin:$PATH"

  # yarn
  export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/.local/bin:$PATH"

  # pnpm
  export PNPM_HOME="$HOME/.local/share/pnpm"
  case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
  esac

  local kernel=`uname`

  if [[ $kernel = "Darwin" ]]; then
    # Programs installed by homebrew should appear before the
    # system-provided equivalents.
    export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:/usr/local/bin:$PATH"
    export MANPATH="/opt/homebrew/opt/coreutils/libexec/gnuman:$MANPATH"
  elif [[ $kernel = "Linux" ]]; then
    # Reference the environment variable created by the systemd unit
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
  fi
}
