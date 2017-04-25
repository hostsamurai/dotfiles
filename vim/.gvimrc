if has('gui_running')
  set ch=2       " Make command line two lines high
  set mousehide  " Hide the mouse when typing text

  " Make shift-insert work like in Xterm
  map <S-Insert> <MiddleMouse>
  map! <S-Insert> <MiddleMouse>

  " Set layout options
  set guioptions-=T "no toolbar
  set guioptions+=g "gray menu items
  set guioptions-=t "no tearoff menu items
  set guioptions-=m "no menubar
  set guioptions-=L "no left scrollbar
  set guioptions-=l "same as above - never present
  set guioptions-=R "no right scrollbar
  set guioptions-=r "same as above - never present

  set guifont=DejaVu\ Sans\ Mono\ 13
  colorscheme fruity
endif
