" (魔境 makyō) - a Zen term meaning "ghost cave" or "devil's cave", a
" perfect description for Vim configuration
"
" ----------------------------------------------------------------------

if &compatible
  set nocompatible
endif

augroup Reset
  autocmd!
augroup END

call makyo#plugins#config#init()      " Plugin configuration via autogroups
call makyo#ux#init()                  " Usability options
call makyo#mappings#init()            " custom mappings
call makyo#ui#init()                  " UI settings
call makyo#functions#setup_commands() " Utility functions and commands
