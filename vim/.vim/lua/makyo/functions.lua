------------
-- Utility functions and commands
-- @module functions

local vimp = require 'vimp'

--- Opens a scratch buffer in a new tab
local function create_scratch_buffer()
  vim.cmd([[tabnew scratch | setlocal buftype=nofile bufhidden=hide noswapfile]])
end

local function init()
  print('[makyo] 🚥 Initializing helper functions and commands...')

  vimp.map_command('Scratch', create_scratch_buffer)

  print('[makyo] 🚥 Done.')
end

return {
  init = init
}
