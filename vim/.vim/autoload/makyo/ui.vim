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
endfunction

function s:adjust_colorscheme(name)
  if a:name == 'horizon'
    hi! link PMenu SneakScope
    hi! link NormalFloat SneakScope

    syntax clear StatusLineNC
    hi! link StatusLineNC airline_a_to_airline_b_inactive

    syntax clear VertSplit
    hi! VertSplit ctermfg=233 ctermbg=233 guifg=#191B23 guibg=#191B23
  endif
endfunction

function! makyo#ui#init()
  echomsg "[makyo] 📺📺📺 Applying UI settings..."

  call s:gui_settings()

  colorscheme horizon

  augroup makyo_ui
    au!
    au User vim-which-key call s:adjust_colorscheme(g:colors_name)
  augroup end

  let g:airline_powerline_fonts=1
  let g:WebDevIconsUnicodeGlyphDoubleWidth=1

  echomsg "[makyo] 📺📺📺 Done."
endfunction
