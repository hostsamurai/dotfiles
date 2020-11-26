------------
--- Runs setup logic after all other modules have been initialized.
-- @module

-- We settle to setting `g:` variables in order to pass values over to
-- scripts in `after/plugin/`. There are commands that simply don't
-- work at the moment, such as `:colorscheme`, which fails to set the
-- color scheme to our liking. Something must be different when
-- running things from Lua scripts rather than `autoload`ed ones...
local function run(opts)
  -- TODO: Set up autocmd's and color scheme here once there's
  -- support for it.
  vim.g.makyo_post_init_options = opts

  vim.cmd([[echomsg "[makyo] Ran post init hooks"]])
end

return {
  run = run
}
