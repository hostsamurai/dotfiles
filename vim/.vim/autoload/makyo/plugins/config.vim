" plugins.vim
"
" Dein setup and non-trivial configuation for plugins
" ----------------------------------------------------------------------

function s:dein_setup()
  let s:dein_dir = expand('~/.cache/dein')
  let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

  if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
  endif

  if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    let g:rc_dir = expand('~/.vim/rc')
    let s:dein_toml = g:rc_dir . '/dein.toml'

    call dein#load_toml(s:dein_toml)

    call dein#end()
    call dein#save_state()
  endif

  syntax enable
  filetype plugin indent on
  runtime macros/matchit.vim

  " Install new plugins on startup
  if dein#check_install()
    call dein#install()
  endif
endfunction


function! makyo#plugins#config#init()
  echomsg "[makyo] 🔌🔌🔌 Initializing plugins..."

  call s:dein_setup()
  call makyo#plugins#denite#config#init()

  echomsg "[makyo] 🔌🔌🔌 Done."
endfunction
