------------
-- Configures FZF
-- @module fzf

-- TODO: Ensure these are setup prior to running the script
local M    = require 'moses'
local vimp = require 'vimp'

vim.env.FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
vim.env.FZF_DEFAULT_COMMAND = "rg --hidden --iglob '!.git' --files "

--- Make fzf delegate its search responsibility to ripgrep. This turns fzf
--  into a simple selector interface.
local function create_dynamic_ripgrep(query, fullscreen)
  local q = query or ''
  local f = fullscreen or false

  local command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  local initial_command = vim.fn.printf(command_fmt, vim.fn.shellescape(q))
  local reload_command = vim.fn.printf(command_fmt, '{q}')
  local spec = {
    options = {'--phony', '--multi', '--query', q, '--bind', 'change:reload:' .. reload_command}
  }
  vim.fn['fzf#vim#grep'](initial_command, 1, vim.fn['fzf#vim#with_preview'](spec), f)
end

-- TODO: How to call this so that it works below?
local function build_quickfix_list(lines)
  -- NOTE: I guess I could've called tbl_map here instead...
  local entries = M.map(lines, function(l) return filename, l end)
  vim.fn.setqflist(entries)
  vim.fn.copen()
  vim.fn.nvim_feedkeys('cc', 'n', true)
end

local function customize_fzf_variables()
  vim.g.fzf_command_prefix = 'Fzf'
  vim.g.fzf_action = {
    --["ctrl-q"] = build_quickfix_list,
    ["ctrl-t"] = 'tab vsplit',
    ["ctrl-s"] = 'split',
    ["ctrl-v"] = 'vsplit'
  }
  vim.g.fzf_history_dir = '~/.local/share/fzf-history'
  -- [Buffers] Jump to existing window if possible
  vim.g.fzf_buffers_jump = 1
  -- [Tags] Command to generate tags files
  vim.g.fzf_tags_command = 'ctags -R'
end

local function create_custom_fzf_commands()
  -- Set up a command for using the advanced rg integration
  -- fn above.
  vimp.map_command('FzfRRG', create_dynamic_ripgrep)

  -- TODO: Convert this appropriately once there's a way to do so
  --       from Lua.
  -- Override [Files] command so that it uses the previewer.
  vim.cmd(
    [[
      command! -bang  -nargs=? -complete=dir FzfFiles
        call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
    ]]
  )
end

local function init()
  print('[makyo][plugins] Setting up fzf...')

  customize_fzf_variables()
  create_custom_fzf_commands()

  print('[makyo][plugins] Done.')
end

return {
  init = init
}
