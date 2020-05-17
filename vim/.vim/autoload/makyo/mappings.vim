" mappings.vim
"
" Custom mode mappings
" ----------------------------------------------------------------------

function! s:setup_mappings()
  " Setup which_key here, as the leader keys are not set up yet when
  " dein sources the plugin.
  try
    au! User vim-which-key call which_key#register('<Space>', "g:which_key_map")
    nnoremap <leader> :<c-u>WhichKey '<Space>'<CR>
    vnoremap <leader> :<c-u>WhichKeyVisual '<Space>'<CR>
  catch
    echoerr "[makyo] Registering mappings failed!"
    echoerr "[makyo] Check for errors in keymap.json5."
    echoerr "[makyo] Additionally, call RegisterKeymap and ensure it works."
  endtry
endfunction

function! makyo#mappings#init()
  echomsg "[makyo] 🗝🗝🗝 Applying custom mappings..."

  let g:mapleader = "\<Space>"
  let g:maplocalleader = ','

  augroup makyo_mappings
    au!
    au VimEnter * call RegisterKeymap()
    au FileWritePost */makyo/keymap.json5 call RegisterKeymap()

    call s:setup_mappings()
  augroup END

  echomsg "[makyo] 🗝🗝🗝 Done."
endfunction
