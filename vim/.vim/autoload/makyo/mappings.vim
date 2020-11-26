" mappings.vim
"
" Custom mode mappings
" ----------------------------------------------------------------------

function! s:setup_mappings()
  " Setup which_key here, as the leader keys are not set up yet when
  " dein sources the plugin.
  nnoremap <leader> :<c-u>WhichKey '<Space>'<CR>
  vnoremap <leader> :<c-u>WhichKeyVisual '<Space>'<CR>
endfunction

function! makyo#mappings#init()
  echomsg "[makyo] 🗝 Applying custom mappings..."

  let g:mapleader = "\<Space>"
  let g:maplocalleader = ','
  let g:which_key_map = {}

  augroup makyo_mappings
    au!
    au VimEnter * call RegisterKeymap()
    au BufWritePost */makyo/keymap.json5 call RegisterKeymap() | call which_key#parse_mappings()
    au User vim-which-key call which_key#register('<Space>', "g:which_key_map")

    call s:setup_mappings()
  augroup END

  echomsg "[makyo] 🗝🗝🗝 Done."
endfunction
