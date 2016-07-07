# ------------------------------------------------
# Path modifications
# ------------------------------------------------
fpath=(
  $fpath
  ~/.zsh/functions
  ~/.zsh/functions/**
)

if [[ -d "$HOME/.rbenv" ]]; then
  path+=("$HOME/.rbenv/bin")
  export PATH
  eval "$(rbenv init -)"
fi

if [[ `uname` = "Darwin" ]]; then
  # Programs installed by homebrew should appear before the
  # system-provided equivalents.
  export PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:$PATH"
  export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
fi
