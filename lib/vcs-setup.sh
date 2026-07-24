#!/bin/sh
# Prompt for VCS user info and substitute into git config.
# Run after mise dotfiles apply links vcs/.

set -e

printf "Enter your username: "
read -r USERNAME
printf "Enter your email: "
read -r EMAIL

VCSDIR="$(dirname "$0")/../vcs"

if [ -f "$VCSDIR/.gitconfig" ]; then
  sed -i "s/USERNAME/$USERNAME/;s/EMAIL/$EMAIL/" "$VCSDIR/.gitconfig"
fi

