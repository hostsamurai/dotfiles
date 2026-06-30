fpath=(
  $fpath
  ~/.zsh/functions/**
  ~/.zsh/hooks/**
)

if [[ `uname` = "Darwin" ]]; then
  setopt no_global_rcs
  export IS_WORK_LAPTOP=1
fi

if [[ $IS_WORK_LAPTOP ]]; then
  source ~/.zshrc_work
fi
