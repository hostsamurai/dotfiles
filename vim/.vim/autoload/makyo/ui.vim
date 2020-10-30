" UI.vim
"
" Terminal and GUI settings
" ----------------------------------------------------------------------

function s:setup_gui()
  " Make shift-insert work like in Xterm
  map <S-Insert> <MiddleMouse>
  map! <S-Insert> <MiddleMouse>

  if xolox#misc#os#is_mac()
    set guifont=FiraCode\ Nerd\ Font:h13
  else
    set guifont=FiraCode\ Nerd\ Font,Noto\ Color\ Emoji:h13
  endif

  " Neovide settings
  let g:neovide_cursor_animation_length=0.13
endfunction

function s:gui_settings()
  set ch=2          " Make command line two lines high
  set mousehide     " Hide the mouse when typing text
  set termguicolors " Set 24-bit RGB color in TUI

  set guioptions-=T " no toolbar
  set guioptions+=g " gray menu items
  set guioptions-=t " no tearoff menu items
  set guioptions-=m " no menubar
  set guioptions-=L " no left scrollbar
  set guioptions-=l " same as above - never present
  set guioptions-=R " no right scrollbar
  set guioptions-=r " same as above - never present
endfunction

function! makyo#ui#init()
  echomsg "[makyo] 📺 Applying UI settings..."

 call s:gui_settings()
  au UIEnter * call s:setup_gui()

  colorscheme horizon

  echomsg "[makyo] 📺 Done."
endfunction
