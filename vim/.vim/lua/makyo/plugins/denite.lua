------------
-- Configures denite
-- @module denite

local vimp = require 'vimp'

local nnoremap = vimp.nnoremap

--- Sets up mappings for interacting with the denite interface.
local function setup_mappings()
  -- All of the mappings below use <silent><buffer><expr>
  local default_map_opts = {'silent', 'buffer', 'expr'}

  nnoremap(default_map_opts, '<CR>',    [[denite#do_map('do_action')]])
  nnoremap(default_map_opts, 'd',       [[denite#do_map('do_action', 'delete')]])
  nnoremap(default_map_opts, 'r',       [[denite#do_map('do_action', 'quickfix')]])
  nnoremap(default_map_opts, 'p',       [[denite#do_map('do_action', 'preview')]])
  nnoremap(default_map_opts, 's',       [[denite#do_map('do_action', 'split')]])
  nnoremap(default_map_opts, 'v',       [[denite#do_map('do_action', 'vsplit')]])
  nnoremap(default_map_opts, 't',       [[denite#do_map('do_action', 'tabopen')]])
  nnoremap(default_map_opts, 'q',       [[denite#do_map('do_action', 'quit')]])
  nnoremap(default_map_opts, 'i',       [[denite#do_map('do_action', 'open_filter_buffer')]])
  nnoremap(default_map_opts, '<Space>', [[denite#do_map('do_action')  . 'j']])
  nnoremap(default_map_opts, '<C-a>',   [[denite#do_map('toggle_select_all')]])
end

--- Sets up insert mode mappings for filtering entries.
local function setup_filter_mappings()
  vimp.imap({'silent', 'buffer'}, '<C-o>', [[<Plug>(denite_filter_quit)]])
end

--- Set up denite and configure rg as its grep source.
local function init()
  print "[makyo][plugins] Setting up denite..."

  local denite_options = {
     split                       = 'floating',
     start_filter                = 1,
     auto_resize                 = 1,
     source_names                = 'short',
     prompt                      = 'λ = ',
     statusline                  = 0,
     highlight_matched_char      = 'WildMenu',
     highlight_matched_range     = 'Visual',
     highlight_window_background = 'Visual',
     highlight_filter_background = 'StatusLine',
     highlight_prompt            = 'StatusLine',
     winrow                      = 1,
     vertical_preview            = 1
  }

  vim.fn['denite#custom#option']( '_', denite_options)

  -- Configure denite to use ripgrep
  vim.fn['denite#custom#var'](
    'file/rec',
    'command',
    {'rg', '--files', '--hidden', '--glob', '!.git'}
  )
  vim.fn['denite#custom#var']('grep', 'command',        {'rg'})
  vim.fn['denite#custom#var']('grep', 'default_opts',   {'-i', '--vimgrep', '--no-heading', '--hidden'})
  vim.fn['denite#custom#var']('grep', 'recursive_opts', {})
  vim.fn['denite#custom#var']('grep', 'pattern_opt',    {'--regexp'})
  vim.fn['denite#custom#var']('grep', 'separator',      {'--'})
  vim.fn['denite#custom#var']('grep', 'final_opts',     {})
end

return {
  setup_mappings        = setup_mappings,
  setup_filter_mappings = setup_filter_mappings,
  init                  = init
}
