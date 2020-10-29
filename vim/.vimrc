" ----------------------------------------------------------------------
"
" (魔境 makyō) - a Zen term meaning "ghost cave" or "devil's cave", a
" perfect description of Vim configuration
"
" ----------------------------------------------------------------------

let g:node_host_prog = '/$HOME/.volta/tools/image/packages/neovim/4.9.0/bin/cli.js'
let g:loaded_python_provider = 0
let g:python3_host_prog = '/usr/bin/python'

call makyo#plugins#config#init()      " Plugin configuration via autogroups
call makyo#ux#init()                  " Usability options
call makyo#mappings#init()            " custom mappings
call makyo#ui#init()                  " UI settings
call makyo#functions#setup_commands() " Utility functions and commands
