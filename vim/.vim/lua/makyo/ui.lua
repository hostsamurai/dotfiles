--- Terminal and GUI settings
-- @module

--- Assigns various GUI options.
local function setup()
  vim.o.ch            = 2    -- Make command line two lines high
  vim.o.termguicolors = true -- Set 24-bit RGB color in TUI

  if vim.fn.has('gui_running') then
    vim.cmd(
      [[
        set guioptions+=g " gray menu items
        set guioptions-=t " no tearoff menu items
        set guioptions-=m " no menubar
        set guioptions-=l " same as above - never present
        set guioptions-=R " no right scrollbar
      ]]
    )
  end

  -- Set neovide settings
  vim.g.neovide_cursor_animation_length = 0.13

  -- Set the font
  if vim.loop.os_uname().sysname == 'Linux' then
    vim.o.guifont = "FiraCode Nerd Font,Noto Color Emoji:h13"
  else
    vim.o.guifont = "FiraCode Nerd Font:h13"
  end

  -- NOTE: The colorscheme doesn't seem to be available when 
  -- set here, even though it appears in the output of 
  -- `getcompletions('', 'colors')`. There might be some 
  -- concurrency involved with packer and how plugins are 
  -- made available. The colorscheme is set using an 
  -- `autocmd` in `plugin/makyo.vim`.
end

--- Initialize GUI settings
local function init()
  print("[makyo] 📺 Applying UI settings...")

  setup()

  print("[makyo] 📺 Done.")
end

return {
  init = init
}
