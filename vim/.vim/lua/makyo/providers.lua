------------
-- Configures language providers
-- @module providers

local function init()
  vim.g.node_host_prog = '/$HOME/.volta/tools/image/packages/neovim/4.9.0/bin/cli.js'
  vim.g.loaded_python_provider = 0
  vim.g.python3_host_prog = '/usr/bin/python'
end

return {
  init = init
}

