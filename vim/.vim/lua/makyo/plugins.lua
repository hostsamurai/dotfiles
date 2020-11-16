--- Install plugins with packer and configures plugins that require non-trivial setup.
-- @module plugins

local packer = require 'makyo.plugins.packer'
local denite = require 'makyo.plugins.denite'
local fzf    = require 'makyo.plugins.fzf'

local function init()
  print("[makyo] 🔌 Initializing plugins...") 

  packer.init()
  denite.init()
  fzf.init()

  print("[makyo] 🔌 Done.")
end

return {
  init = init
}
