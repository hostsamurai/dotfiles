" UX.vim
"
"  Basic usability options
" ----------------------------------------------------------------------

function s:basic_options()
  set backspace=indent,eol,start " allow backspacing over everything in insert mode
  set backup                     " keep a backup file
  set backupdir=~/.vim/backups
  set directory=~/.vim/tmp
  set history=10000              " keep 10000 lines of command line history
  set ruler                      " show the cursor position all the time
  set showcmd                    " display incomplete commands
  set incsearch                  " do incremental searching
  set showmatch                  " jumps to a matching symbol briefly
  set hlsearch                   " highlight any search pattern matches
  set encoding=UTF-8             " string encoding used internally
  set fileencoding=UTF-8         " file content encoding
  set ruler                      " show cursor position
  set showcmd                    " show partial commands
  set lazyredraw
  set matchtime=3                " time (ms) duration spent showing matching paren
  set autowrite                  " write file contents when moving away from buffer
  set autoread                   " read file when changes detected outside of Vim
  set shiftround                 " round indentation values to multiples of shiftwidth
  set linebreak                  " wrap long lines
  set ignorecase smartcase       " case insensitive search
  set hidden                     " hide a buffer when it is abandoned
  set laststatus=2               " always show a statusline
  set cmdheight=2                " command line height
  set relativenumber             " show line numbers relative to the current lien
  set inccommand="nosplit"       " show effects of a command as you type
  set sessionoptions=resize,winpos,winsize,buffers,tabpages,folds,curdir,localoptions,help

  " Hide the tabline - rely on CtrlSpace for navigation instead.
  set showtabline=0

  set expandtab " turn tabs into spaces
  set formatoptions=tcqrn

  " Don't attempt to highlight lines > 800 characters
  set synmaxcol=800

  set foldlevelstart=99

  " Better completion
  set complete=.,w,b,u,t
  set completeopt=longest,menuone,preview

  set grepprg=rg " Use ripgrep instead of regular grep

  " Wildmenu completion
  set wildmenu                              " enhanced command-line completion
  set wildmode   =list:longest,full
  set wildignore +=.hg,.git,.svn            " version control
  set wildignore +=*.jpg,*.gif,*.png,*.jpeg " binary images

  " Tag options
  set tags=./tags;${HOME}

  if !has('nvim')
    set ttyfast
  endif
endfunction


function s:autocommands()
  " save on losing focus when moving away from tab
  au FocusLost * :wa
  " resize splits when the window is resized
  au VimResized * :wincmd =
endfunction


function s:commands()
  " Convenient command to see the difference between the current buffer and the
  " file it was loaded from, thus the changes you made.
  if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
  		  \ | wincmd p | diffthis
  endif
endfunction


function s:autogroups()
  " Only show the cursorline in the current window and in normal mode
  augroup cline
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
  augroup END

  " Make sure vim returns to the same line when you reopen a file.
  augroup line_return
      au!
      au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   execute 'normal! g`"zvzz' |
    \ endif
  augroup END
endfunction


function! makyo#ux#init()
  echomsg "[makyo] 🔨🔨🔨 Applying UX settings..."

  call s:basic_options()
  call s:autocommands()
  call s:autogroups()

  echomsg "[makyo] 🔨🔨🔨 Done."
endfunction
