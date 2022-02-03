------------
--- Runs setup logic after all other modules have been initialized.
-- @module

--- Code to run after we're done loading plugins.
-- Creates a timer to wait until certain plugins are done being sourced.
-- Because we're using Packer to manage the plugins, we have to load 
-- the Fennel entry point module here, rather than rely on loading it
-- via init.vim.
local function plugin_post_init_hook()
  local timer = vim.loop.new_timer()

  timer:start(1000, 750, vim.schedule_wrap(function() 
    if vim.g.loaded_aniseed then
      require('aniseed.env').init({ module = 'makyo-fnl.init' })
    end
  end))
end

-- We settle to setting `g:` variables in order to pass values over to
-- scripts in `after/plugin/`. There are commands that simply don't
-- work at the moment, such as `:colorscheme`, which fails to set the
-- color scheme to our liking. Something must be different when
-- running things from Lua scripts rather than `autoload`ed ones...
local function run(opts)
  -- TODO: Set up autocmd's and color scheme here once there's
  -- support for it.
  vim.g.makyo_post_init_options = opts
  plugin_post_init_hook()
  vim.cmd([[echomsg "[makyo] Ran post init hooks"]])
end

return {
  run = run
}
