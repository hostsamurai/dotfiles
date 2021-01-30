------------
-- Configures VIM

-- Require all modules that contain settings
local plugins = require 'makyo.plugins'
local post_init_hooks = require 'makyo.hooks.post_init'

do
  plugins.init()

  vim.cmd([[echomsg "[makyo] Finished loading."]])
  post_init_hooks.run({colorscheme = 'horizon'})
end
