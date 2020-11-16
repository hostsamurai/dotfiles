------------
-- Configures VIM

local pre_init_hooks  = require 'makyo.hooks.pre_init'
local post_init_hooks = require 'makyo.hooks.post_init'

pre_init_hooks.run({configure_path = vim.g.neovide})

require 'luarocks.loader'

-- Require all modules that contain settings
local providers = require 'makyo.providers'
local plugins   = require 'makyo.plugins'
local UX        = require 'makyo.ux'
local UI        = require 'makyo.ui'
local fns       = require 'makyo.functions'


-- Load defaults first, so we can override the ones we want later
vim.api.nvim_command([[runtime! plugin/default.vim]])

providers.init()
plugins.init()
UX.init()
UI.init()
fns.init()

post_init_hooks.run({colorscheme = 'horizon'})
