" UI.vim
"
" Terminal and GUI settings
" ----------------------------------------------------------------------

function s:terminal_settings()
  set t_Co=256
  let g:solarized_termcolors=256
  set background=dark
endfunction

function s:gui_settings()
  if has('gui_running')
    set ch=2       " Make command line two lines high
    set mousehide  " Hide the mouse when typing text

    set guioptions-=T "no toolbar
    set guioptions+=g "gray menu items
    set guioptions-=t "no tearoff menu items
    set guioptions-=m "no menubar
    set guioptions-=L "no left scrollbar
    set guioptions-=l "same as above - never present
    set guioptions-=R "no right scrollbar
    set guioptions-=r "same as above - never present
  endif
endfunction

function! makyo#ui#init()
  echomsg "[makyo] 📺📺📺 Applying UI settings..."
  call s:terminal_settings()
  call s:gui_settings()

  colorscheme horizon

  echomsg "[makyo] 📺📺📺 Done."
endfunction
