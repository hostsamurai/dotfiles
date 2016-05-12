UNAME_S := $(shell uname -s)
black := 0
green := 2
cyan  := 6
white := 7
command-width := 15

ifeq ($(UNAME_S), Linux)
	ignore = '.tmux-osx.conf'
else
	ignore = '.gvimrc'
endif

define print-bold-header
	tput bold
	tput setaf ${black}
	echo "------------------------------------------------------------"
	tput smso
	tput setaf ${cyan}
	echo $1
	tput rmso
	tput setaf ${black}
	echo "------------------------------------------------------------"
	tput sgr0
endef

define print-bold-text
	tput bold
	tput setaf $1
	echo $2
	tput sgr0
	echo
endef

define print-help-text
	tput bold
	tput setaf ${white}
	printf "%2s%-${command-width}s" " " $1
	tput sgr0
	printf "%s" $2
	tput sgr0
	echo
endef

.PHONY: all
all: zsh vcs tmux vim spacemacs configs

.PHONY: help
help:
	@echo
	@$(call print-bold-text, ${green}, "Usage:")
	@$(call print-help-text, "make all",       "stow all the things!")
	@$(call print-help-text, "make zsh",       "stow ZSH configuration files")
	@$(call print-help-text, "make vcs",       "stow version control configuration files")
	@$(call print-help-text, "make tmux",      "stow tmux configuration files")
	@$(call print-help-text, "make vim",       "stow Vim configuration files and .vim directory")
	@$(call print-help-text, "make spacemacs", "stow spacemacs config")
	@$(call print-help-text, "make configs",   "stow miscellaneous dotfiles")
	@$(call print-help-text, "make clean",     "unstow everything")
	@echo

.PHONY: zsh
zsh:
	@$(call print-bold-header, "Stowing zsh...")
	stow -R zsh

.PHONY: tmux
tmux:
	@$(call print-bold-header, "Stowing tmux...")
	stow -R tmux --ignore $(ignore)

.PHONY: vcs
vcs:
	@$(call print-bold-header, "Stowing version control stuff...")
	@echo
	@$(call print-bold-text, ${white}, "Setting up VCS user info...")
	@echo
	stow -R vcs
	@printf "Enter your username: "; \
		read USERNAME; \
		printf "Enter your email: "; \
		read EMAIL; \
		sed -i "s/USERNAME/$$USERNAME/;s/EMAIL/$$EMAIL/" vcs/.gitconfig vcs/.hgrc;
	@echo

.PHONY: vim
vim:
	@$(call print-bold-header, "Stowing vim...")
	stow -R vim --ignore $(ignore)

.PHONY: spacemacs
spacemacs:
	@$(call print-bold-header, "Stowing spacemacs...")
	stow -R spacemacs

.PHONY: configs
configs:
	stow -R configs

.PHONY: clean
clean:
	stow -D zsh vcs tmux vim spacemacs configs
