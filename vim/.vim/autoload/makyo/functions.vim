" functions.vim
"
"  Utility Functions and Commands
" ----------------------------------------------------------------------

function! makyo#functions#preserve(command)
  " Preparation: save last search and cursor position
  let _s = @/
  let l = line('.')
  let c = col('.')
  " Do the business:
  execute a:command
  " Clean up: restore previous cursor position and search history
  let @/=_s
  call cursor(l,c)
endfunction


" quick and dirty way to create a scratch buffer
function! makyo#functions#scratch()
  execute "tabnew scratch | setlocal buftype=nofile bufhidden=hide noswapfile"
endfunction


" temporary fix tab spacing in a buffer
function! makyo#functions#tab_toggle()
  setlocal ci pi sts=0 sw=4 ts=4
endfunction


" preview link in browser
function! makyo#functions#handle_URI()
  let s:uri = matchstr(getline("."), "[a-z]*:\/\/[^ >,;:]*")
  echo s:uri
  if s:uri != ""
    exec "!firefox \"" . s:uri . "\""
    else
    echo "No URI found in line"
  endif
endfunction


function! makyo#functions#setup_commands()
  echomsg "[makyo] 🚥🚥🚥 Initializing helper functions and commands..."

  " strip trailing whitespace before saving a file
  autocmd BufWritePre * :call makyo#functions#preserve('%s/\v\s+$//e')

  command! Scratch   :call makyo#functions#scratch()
  command! TabToggle :call makyo#functions#tab_toggle()
  command! HandleURI :call makyo#functions#handle_URI()

  echomsg "[makyo] 🚥🚥🚥 Done."
endfunction
