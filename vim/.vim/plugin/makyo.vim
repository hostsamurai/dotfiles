function s:run_post_init_hook(opts)
  augroup Makyo
    autocmd!
    
    " Only show the cursorline in the current window and in normal mode
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline

    " Make sure vim returns to the same line when you reopen a file.
    au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   execute 'normal! g`"zvzz' |
    \ endif

    if get(a:opts, 'colorscheme', '') != ''
      execute 'colorscheme ' . a:opts.colorscheme
    endif
  augroup END
endfunction

command! -nargs=1 MakyoPostInitHooks call s:run_post_init_hook(<args>)
