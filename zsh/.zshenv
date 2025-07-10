fpath=(
  $fpath
  ~/.zsh/functions
  ~/.zsh/functions/**
)

if [[ `uname` = "Darwin" ]]; then
  setopt no_global_rcs
  export IS_WORK_LAPTOP=1
fi
