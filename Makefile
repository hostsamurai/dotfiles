UNAME_S := $(shell uname -s)
BLACK = 0
GREEN = 2
CYAN	= 6
WHITE = 7
command-width = 15

ifeq ($(UNAME_S), Linux)
	ignore = '.tmux-osx.conf'
else
	ignore = '.gvimrc'
endif

define print-bold-header
	tput bold
	tput setaf ${BLACK}
	echo "------------------------------------------------------------"
	tput smso
	tput setaf ${CYAN}
	echo $1
	tput rmso
	tput setaf ${BLACK}
	echo "------------------------------------------------------------"
	tput sgr 0
endef

define print-bold-text
	tput bold
	tput setaf $1
	echo $2
	tput sgr 0
endef

define print-help-text
	tput bold
	tput setaf ${WHITE}
	printf "%2s%-${command-width}s" " " $1
	tput sgr 0
	tput dim
	printf "%s" $2
	tput sgr 0
endef

.PHONY: zsh vcs tmux vim spacemacs
all: zsh vcs tmux vim spacemacs

help:
	@echo
	@$(call print-bold-text, ${GREEN}, "Usage:")
	@echo
	@$(call print-help-text,	"make all",				"stow all the things!")
	@echo
	@$(call print-help-text,	"make zsh",				"stow ZSH configuration files")
	@echo
	@$(call print-help-text,	"make vcs",				"stow version control configuration files")
	@echo
	@$(call print-help-text,	"make tmux",			"stow tmux configuration files")
	@echo
	@$(call print-help-text,	"make vim",				"stow Vim configuration files and .vim directory")
	@echo
	@$(call print-help-text,	"make spacemacs", "stow spacemacs config")
	@echo
	@$(call print-help-text,	"make clean",			"unstow everything")
	@echo
	@echo

zsh:
	@$(call print-bold-header, "Stowing zsh...")
	stow -R zsh

tmux:
	@$(call print-bold-header, "Stowing tmux...")
	stow -R tmux --ignore $(ignore)

vcs:
	@$(call print-bold-header, "Stowing version control stuff...")
	@echo
	@$(call print-bold-text, ${WHITE}, "Setting up VCS user info...")
	@echo
	stow -R vcs
	@printf "Enter your username: "; \
		read USERNAME; \
		printf "Enter your email: "; \
		read EMAIL; \
		sed -i "s/USERNAME/$$USERNAME/;s/EMAIL/$$EMAIL/" vcs/.gitconfig vcs/.hgrc;
	@echo

vim:
	@$(call print-bold-header, "Stowing vim...")
	stow -R vim --ignore $(ignore)

spacemacs:
	@$(call print-bold-header, "Stowing spacemacs...")
	stow -R spacemacs

clean:
	stow -D zsh vcs tmux vim spacemacs
