" (魔境 makyō) - a Zen term meaning "ghost cave" or "devil's cave", a
" perfect description of Vim configuration
"
" ----------------------------------------------------------------------

let g:node_host_prog = '/$HOME/.volta/tools/image/packages/neovim/4.5.0/bin/cli.js'
echo g:node_host_prog
call makyo#plugins#config#init()      " Plugin configuration via autogroups
call makyo#ux#init()                  " Usability options
call makyo#mappings#init()            " custom mappings
call makyo#ui#init()                  " UI settings
call makyo#functions#setup_commands() " Utility functions and commands
