-- [nfnl] init.fnl
local lazy_base_path = (vim.fn.stdpath("data") .. "/lazy")
local lazy_path = (lazy_base_path .. "/lazy.nvim")
local nfnl_path = (lazy_base_path .. "/nfnl")
local nvim_lua_path = (lazy_base_path .. "/nvim.lua")
local makyo_start_augroup = vim.api.nvim_create_augroup("makyo.startup", {clear = true})
local function lazy_exists_3f()
  return pcall(require, "lazy")
end
local function is_nfnl_installed_3f()
  return pcall(require, "nfnl.core")
end
local function running_headless_3f()
  return (#vim.api.nvim_list_uis() == 0)
end
local function restart_neovim()
  return vim.api.nvim_cmd({cmd = "restart", args = "+qall!"})
end
local function start_makyo()
  return require("makyo-fnl.init")
end
local function plugins_already_installed_3f()
  local dir_count = #vim.fn.globpath(lazy_base_path, "*", 0, 1)
  return (dir_count > 4)
end
local function bootstrap_lazy()
  local lazy_path0 = (vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
  if not vim.loop.fs_stat(lazy_path0) then
    vim.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazy_path0}):wait()
  else
  end
  return vim.opt.rtp:prepend(lazy_path0)
end
local function restore_plugins()
  local lazy = require("lazy")
  vim.opt.rtp:prepend(nfnl_path)
  vim.opt.rtp:prepend(nvim_lua_path)
  if not is_nfnl_installed_3f() then
    lazy.setup({spec = {"Olical/nfnl", "norcalli/nvim.lua"}})
    vim.print("[makyo] \240\159\148\140 Successfully installed core plugins. Restarting to restore the rest...")
    restart_neovim()
  else
  end
  lazy.setup("makyo-fnl.plugins.lazy.plugins")
  if not plugins_already_installed_3f() then
    lazy.restore()
  else
  end
  if (plugins_already_installed_3f() and not running_headless_3f()) then
    vim.api.nvim_exec_autocmds({"User"}, {group = makyo_start_augroup, pattern = "LazyDone"})
  else
  end
  return vim.print("[makyo] \240\159\148\140 Plugins have been restored.")
end
local function compile_all_files()
  local _let_5_ = require("nfnl.api")
  local compile_all_files0 = _let_5_["compile-all-files"]
  local config_dir = vim.fn.stdpath("config")
  local makyo_lua_dir = (config_dir .. "/lua/makyo-fnl")
  if not vim.loop.fs_stat(makyo_lua_dir) then
    vim.print("[makyo] Compiling config files")
    compile_all_files0(config_dir)
    vim.print("[makyo] Done. Restarting...")
    return restart_neovim()
  else
    return nil
  end
end
local function prepare_lazy_done_hook()
  local startup_augroup = makyo_start_augroup
  return vim.api.nvim_create_autocmd({"User"}, {group = startup_augroup, pattern = "LazyDone", callback = start_makyo})
end
local function init()
  if running_headless_3f() then
    bootstrap_lazy()
    restore_plugins()
    return compile_all_files()
  else
    bootstrap_lazy()
    prepare_lazy_done_hook()
    return restore_plugins()
  end
end
return init()
