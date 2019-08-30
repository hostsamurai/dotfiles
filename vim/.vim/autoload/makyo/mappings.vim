" mappings.vim
"
" Custom mode mappings
" ----------------------------------------------------------------------

function! makyo#mappings#init()
  echomsg "[makyo] 🗝🗝🗝 Applying custom mappings..."

  augroup makyo
    autocmd VimEnter * call RegisterKeymap()
    autocmd FileWritePost */makyo/keymap.json5 call RegisterKeymap()
  augroup END

  echomsg "[makyo] 🗝🗝🗝 Done."
endfunction
