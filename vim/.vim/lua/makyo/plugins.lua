--- Install plugins with packer and configures plugins that require non-trivial setup.
-- @module plugins

local packer = require 'makyo.plugins.setup'

local function init()
  print("[makyo] 🔌 Initializing plugins...") 

  packer.init()

  print("[makyo] 🔌 Done.")
end

return {
  init = init
}
