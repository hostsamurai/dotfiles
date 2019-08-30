function s:denite_ft_mappings() abort
  nnoremap <silent><buffer><expr> <CR>    denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d       denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> r       denite#do_map('do_action', 'quickfix')
  nnoremap <silent><buffer><expr> p       denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q       denite#do_map('quit')
  nnoremap <silent><buffer><expr> i       denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select') .'j'
  nnoremap <silent><buffer><expr> <C-a>   denite#do_map('toggle_select_all')
endfunction


function s:denite_filter_mappings() abort
  imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
endfunction


function s:replace_all(context)
  echomsg "In s:replace_all"
  let qflist = []

  for target in a:context['targets']
    if !has_key(target, 'action__path') | continue | endif
    if !has_key(target, 'action__line') | continue | endif
    if !has_key(target, 'action__text') | continue | endif

    call add(qflist, {
    \ 'filename': target['action__path'],
    \ 'lnum':     target['action__line'],
    \ 'text':     target['action__text']
    \})
  endfor

  call setqflist(qflist)
  call qfreplace#start('')
endfunction


function! makyo#plugins#denite#config#init()
  echomsg "[makyo][plugins] Setting up denite augroup..."

  augroup makyoConfig#Plugin#denite
    au!

    " Custom options
    " TODO: Can we configure this a better way? TOML? Lua?
    let s:denite_options = {
    \ 'split': 'floating',
    \ 'start_filter': 1,
    \ 'auto_resize': 1,
    \ 'source_names': 'short',
    \ 'prompt': 'λ:',
    \ 'statusline': 0,
    \ 'highlight_matched_char': 'WildMenu',
    \ 'highlight_matched_range': 'Visual',
    \ 'highlight_window_background': 'Visual',
    \ 'highlight_filter_background': 'StatusLine',
    \ 'highlight_prompt': 'StatusLine',
    \ 'winrow': 1,
    \ 'vertical_preview': 1
    \}
    call denite#custom#option('_', s:denite_options)

    call denite#custom#var('file/rec', 'command', ['rg', '--files', '--hidden', '--glob', '!.git'])

    " Ripgrep command on grep source
    call denite#custom#var('grep', 'command', ['rg'])
    call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep', '--no-heading', '--hidden'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])

    " Open file commands
    call denite#custom#map('normal', "tt", '<denite:do_action:tabopen>', 'noremap')
    call denite#custom#map('normal', "tv", '<denite:do_action:vsplit>', 'noremap')
    call denite#custom#map('normal', "ts", '<denite:do_action:split>', 'noremap')

    " Define mappings
    autocmd FileType denite call s:denite_ft_mappings()
    autocmd FileType denite-filter call s:denite_filter_mappings()
  augroup END
endfunction
