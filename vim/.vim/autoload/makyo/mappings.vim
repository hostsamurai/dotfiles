" mappings.vim
"
" Custom mode mappings
" ----------------------------------------------------------------------

function! makyo#mappings#init()
  echomsg "[makyo] 🗝🗝🗝 Applying custom mappings..."

  augroup makyo
    au!
    autocmd VimEnter * call RegisterKeymap()
    autocmd FileWritePost */makyo/keymap.json5 call RegisterKeymap()

    let g:mapleader = "\<Space>"
    let g:maplocalleader = ','

    call which_key#register('<Space>', "g:which_key_map")

    nnoremap <leader> :<c-u>WhichKey '<Space>'<CR>
    vnoremap <leader> :<c-u>WhichKeyVisual '<Space>'<CR>
  augroup END

  echomsg "[makyo] 🗝🗝🗝 Done."
endfunction
