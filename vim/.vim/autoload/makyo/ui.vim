" UI.vim
"
" Terminal and GUI settings
" ----------------------------------------------------------------------

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

  if has('gui_running')
    " Make shift-insert work like in Xterm
    map <S-Insert> <MiddleMouse>
    map! <S-Insert> <MiddleMouse>

    set guifont=FiraCode\ Nerd\ Font:h13

    " Neovide settings
    let g:neovide_cursor_animation_length=0.13
  endif
endfunction

function! makyo#ui#init()
  echomsg "[makyo] 📺 Applying UI settings..."

  call s:gui_settings()

  colorscheme horizon

  echomsg "[makyo] 📺 Done."
endfunction
