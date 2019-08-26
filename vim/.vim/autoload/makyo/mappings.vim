" mappings.vim
"
" Custom mode mappings
" ----------------------------------------------------------------------

function s:navigation_mappings()
  noremap j gj
  noremap k gk
  noremap gj j
  noremap gk k

  " easier window navigation
  nnoremap <C-h> <C-w>h
  nnoremap <C-j> <C-w>j
  nnoremap <C-k> <C-w>k
  nnoremap <C-l> <C-w>l

  " heretical mappings for command-line mode
  cnoremap <C-A> <Home>
  " back one character
  cnoremap <C-B> <Left>
  " delete character under cursor
  cnoremap <C-D> <Del>
  " end of line
  cnoremap <C-E> <End>
  " forward one character
  cnoremap <C-F> <Right>
  " recall newer command-line
  cnoremap <C-N> <Down>
  " recall previous (older) command-line
  cnoremap <C-P> <Up>
endfunction


function s:search_mappings()
  " use sane regexes
  nnoremap / /\v
  vnoremap / /\v
  nnoremap ? ?\v
  vnoremap ? ?\v
  nnoremap s/ s/\v
  cnoremap s/ s/\v
  vnoremap s/ s/\v
  cnoremap %s/ %s/\v
  vnoremap %s/ %s/\v

  " clear search highlights
  noremap <silent> <space>sc :nohls<CR>

  " search for word under the cursor
  noremap <Leader>g :exe "Ag! -R " . shellescape(expand("<cWORD>")) . " ."<cr>
endfunction


function s:text_manipulation_mappings()
  " CTRL-U in insert mode deletes a lot. Use CTRL-G u to first break undo,
  " so that you can undo CTRL-U after inserting a line break.
  inoremap <C-U> <C-G>u<C-U>

  " Don't use Ex mode, use Q for formatting
  noremap Q gq

  " delete the current line w/ '-'
  nnoremap - dd

  " Delete text after the cusor position in insert mode.
  " Useful for deleting superflous quote marks left by auto-closing plugins.
  inoremap <C-d> <C-[>ld$A

  " move visual selection up and down
  " see: https://twitter.com/MasteringVim/status/800982553943543809?s=09
  vnoremap J :m '>+1<CR>gv=gv'
  vnoremap K :m '<-2<CR>gv=gv'

  " escape from insert mode w/out stretching your fingers
  inoremap jk <esc>

  " make Y behave like other capitals
  nnoremap Y y$
endfunction


function s:ui_helper_mappings()
  " easier tab creation
  nnoremap tc :tabnew<CR>

  " moving around tabs
  nnoremap <Leader>( :tabprev<cr>
  nnoremap <Leader>) :tabnext<cr>

  " TODO: toggle folds
  "noremap <Space> zA
endfunction


function s:misc_mappings()
  " using sudo to write a file
  cnoremap w!! w !sudo tee % >/dev/null

  " edit and source vimrc easier
  nnoremap <Leader>ev :tabnew $MYVIMRC<CR>
  nnoremap <Leader>sv :so $MYVIMRC<CR>
endfunction


function! makyo#mappings#init()
  echomsg "[makyo] 🗝🗝🗝 Applying custom mappings..."

  call s:navigation_mappings()
  call s:search_mappings()
  call s:text_manipulation_mappings()
  call s:ui_helper_mappings()
  call s:misc_mappings()

  echomsg "[makyo] 🗝🗝🗝 Done."
endfunction
