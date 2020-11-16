" Run post init hooks on VimEnter. The `g:makyo_post_init_options` 
" variable is set in the Lua Makyo post hook.
au VimEnter * 
  \ if exists(':MakyoPostInitHooks') && exists('g:makyo_post_init_options') |
  \   execute('MakyoPostInitHooks ' . string(g:makyo_post_init_options)) |
  \ endif
