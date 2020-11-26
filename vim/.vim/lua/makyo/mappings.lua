--- Keybindings configuration
-- @module

local keymap = vim.api.nvim_set_keymap

local function setup_better_regexes()
    keymap('n', '/',  '/\\v',  {noremap = true})
    keymap('n', '?',  '?\\v',  {noremap = true})
    keymap('n', 's/', 's/\\v', {noremap = true})

    keymap('c', 's/',  's/\\v',  {noremap = true})
    keymap('c', '%s/', '%s/\\v', {noremap = true})

    keymap('v', '/',   '/\\v',   {noremap = true})
    keymap('v', '?',   '?\\v',   {noremap = true})
    keymap('v', 's/',  's/\\v',  {noremap = true})
    keymap('v', '%s/', '%s/\\v', {noremap = true})
end

local function setup_normal_mode_mappings()
    -- Easier window navigation
    keymap('n', '<C-h>', '<C-w>h', {noremap = true})
    keymap('n', '<C-j>', '<C-w>j', {noremap = true})
    keymap('n', '<C-k>', '<C-w>k', {noremap = true})
    keymap('n', '<C-l>', '<C-w>l', {noremap = true})
end

local function setup_command_mode_mappings()
    -- Heretical mappings
    -- Ctrl + a --> Jump to beginning of line
    -- Ctrl + b --> Back one character
    -- Ctrl + d --> Delete one character
    -- Ctrl + e --> Jump to end of line
    -- Ctrl + f --> Forward one character
    -- Ctrl + n --> Go forwards in history to the a newer entry
    -- Ctrl + p --> Go backwards in history to an older entry
    keymap('c', '<C-A>', '<Home>',  {noremap = true})
    keymap('c', '<C-B>', '<Left>',  {noremap = true})
    keymap('c', '<C-D>', '<Del>',   {noremap = true})
    keymap('c', '<C-E>', '<End>',   {noremap = true})
    keymap('c', '<C-F>', '<Right>', {noremap = true})
    keymap('c', '<C-N>', '<Down>',  {noremap = true})
    keymap('c', '<C-P>', '<Up>',    {noremap = true})

    -- Using sudo to write to a file
    keymap('c', 'w!!', 'w !sudo tee % >/dev/null', {noremap = true})
end

local function setup_insert_mode_mappings()
    keymap('i', '<C-l>', '<Plug>(coc-snippets-expand)', {})
    keymap('i', '<C-j>', '<Plug>(coc-snippets-expand-jump)', {})

    -- jk --> Escape from insert mode without stretching your fingers
    keymap('i', 'jk', '<ESC>', {noremap = true})
    -- Ctrl + U --> CTRL-U in insert mode deletes a lot. Use CTRL-G u to first break undo,
    keymap('i', '<C-U>', '<C-G>u<C-U>', {noremap = true})
    -- Ctrl + d --> Delete text after the cusor position in insert mode.
    keymap('i', '<C-d>', [[<C-\[>ld\$A]], {noremap = true})
end

local function setup_visual_mode_mappings()
  keymap('v', '<enter>', '<Plug>(EasyAlign)', {})
  keymap('v', '<C-j>', '<Plug>(coc-snippets-select)', {})

    keymap('v', '<leader>*', [[:<C-u>call VisualStarSearchSet('/', 'raw')<CR>:call ag#Ag('grep', '--literal ' . shellescape(@/))<CR>]], {noremap = true})

    -- LISP mode visual mappings
    keymap('v', '<leader>mlc', ':execute "normal gv" . maplocalleader . "Ea("<CR>', {noremap = true})
    keymap('v', '<leader>mlE', ':execute "normal gv" . maplocalleader . "E"<CR>',   {noremap = true})
    keymap('v', '<leader>mlw', ':execute "normal gv" . maplocalleader . "Eiw"<CR>', {noremap = true})
end

local function setup_terminal_mode_mappings()
    -- Navigate windows from the terminal using Alt + h/j/k/l
    keymap('t', '<A-h>', '<C-><C-N><C-w>h', {noremap = true})
    keymap('t', '<A-j>', '<C-><C-N><C-w>j', {noremap = true})
    keymap('t', '<A-k>', '<C-><C-N><C-w>k', {noremap = true})
    keymap('t', '<A-l>', '<C-><C-N><C-w>l', {noremap = true})

    -- Simulate i_CTRL-R for inserting the contents of a register
    keymap('t', '<expr> <C-R>', "'<C-><C-N>\"' . nr2char(getchar()) . 'pi'", {noremap = true})

    -- Exit terminal mode easily
    keymap('t', "<Esc>",      "<C-><C-N>", {noremap = true})
    keymap('t', "<M-[>",      "<Esc>",     {noremap = true})
    keymap('t', "<C-v><Esc>", "<Esc>",     {noremap = true})
end
 
local function setup_mappings()
    keymap('', ';', '<Plug>(clever-f-repeat-forward)', {})
    keymap('', ',', '<Plug>(clever-f-repeat-back)', {})

    keymap('', '<Tab>', ':b#<cr>', {})

    -- Easier navigation on line-wrapped text
    keymap('', 'j', 'gj', {noremap = true})
    keymap('', 'k', 'gk', {noremap = true})
    keymap('', 'gj', 'j', {noremap = true})
    keymap('', 'gk', 'k', {noremap = true})

    keymap('', 'tc', ':tabnew<CR>', {noremap = true})
end

local function init()
  print('[makyo] 🗝 Applying custom mappings...')

  setup_better_regexes()
  setup_normal_mode_mappings()
  setup_command_mode_mappings()
  setup_insert_mode_mappings()
  setup_visual_mode_mappings()
  setup_terminal_mode_mappings()
  setup_mappings()

  print('[makyo] 🗝 Done.')
end

return {
  init = init
}
