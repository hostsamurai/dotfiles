------------
-- Configures VIM

local pre_init_hooks  = require 'makyo.hooks.pre_init'
local post_init_hooks = require 'makyo.hooks.post_init'

-- TODO: Remove this once Packer can deal with luarocks packages.
pre_init_hooks.run({ configure_path = vim.g.neovide })

require 'luarocks.loader'

-- Require all modules that contain settings
local plugins = require 'makyo.plugins'

do
  plugins.init()

  vim.cmd([[echomsg "[makyo] Finished loading."]])
  post_init_hooks.run({colorscheme = 'horizon'})
end
