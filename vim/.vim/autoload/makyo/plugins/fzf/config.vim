let $FZF_DEFAULT_OPTS = "--layout=reverse --info=inline"
let $FZF_DEFAULT_COMMAND = "rg --hidden --iglob '!.git' --files "

" Make fzf delegate its search responsibility to ripgrep. This turns fzf
" into a simple selector interface.
fun! s:advanced_ripgrep_fzf(query,  fullscreen) abort
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--multi', '--query', a:query, '--bind', 'change:reload:' . reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endf

fun! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endf

fun! s:create_custom_fzf_commands()
  " Setup a command for the advanced RG command
  command! -nargs=* -bang FzfRRG
    \ call s:advanced_ripgrep_fzf(<q-args>, <bang>0)
  " Override Files command so that it uses the previewer
  command! -nargs=? -bang -complete=dir FzfFiles
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
endf

fun! s:customize_fzf_variables()
  let g:fzf_command_prefix = 'Fzf'
  let g:fzf_action = {
    \ 'ctrl-q': {lines -> s:build_quickfix_list(lines)},
    \ 'ctrl-t': 'tab vsplit',
    \ 'ctrl-s': 'split',
    \ 'ctrl-v': 'vsplit',
    \ }
  let g:fzf_history_dir = '~/.local/share/fzf-history'
  " [Buffers] Jump to existing window if possible
  let g:fzf_buffers_jump = 1
  " [Tags] Command to generate tags files
  let g:fzf_tags_command = 'ctags -R'
endf

fun! makyo#plugins#fzf#config#init()
  echomsg "[makyo][plugins] Setting up fzf augroup..."

  augroup makyoConfig#Plugin#fzf
    au!

    call s:customize_fzf_variables()
    call s:create_custom_fzf_commands()
  augroup END
endf
