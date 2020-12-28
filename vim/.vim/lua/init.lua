------------
-- Configures VIM

local pre_init_hooks  = require 'makyo.hooks.pre_init'
local post_init_hooks = require 'makyo.hooks.post_init'

pre_init_hooks.run({ configure_path = vim.g.neovide })

require 'luarocks.loader'

-- Require all modules that contain settings
local providers = require 'makyo.providers'
local plugins   = require 'makyo.plugins'
local UX        = require 'makyo.ux'
local UI        = require 'makyo.ui'
local fns       = require 'makyo.functions'
local mappings  = require 'makyo.mappings'

-- Load defaults first, so we can override the ones we want later
-- FIXME: don't think that the better defaults plugin is run here;
-- it runs later, causing our overrides to not be applied.
vim.g.vim_better_default_key_mapping = 0
vim.g.vim_better_default_persistent_undo = 1
vim.api.nvim_command([[packadd vim-better-default]])

do
  providers.init()
  plugins.init()
  UX.init()
  UI.init()
  fns.init()
  mappings.init()

  vim.cmd([[echomsg "[makyo] Finished loading."]])
  post_init_hooks.run({colorscheme = 'horizon'})
end
