-- [nfnl] init.fnl
local lazy_base_path = (vim.fn.stdpath("data") .. "/lazy")
local lazy_path = (lazy_base_path .. "/lazy.nvim")
local nfnl_path = (lazy_base_path .. "/nfnl")
local nvim_lua_path = (lazy_base_path .. "/nvim.lua")
local nvim_config_path = vim.fn.stdpath("config")
local nvim_config_lua_path = (nvim_config_path .. "/lua")
local nvim_fnl_path = (nvim_config_path .. "/fnl")
local makyo_start_augroup = vim.api.nvim_create_augroup("makyo.startup", {clear = true})
local function lazy_exists_3f()
  return pcall(require, "lazy")
end
local function is_installed_3f(module)
  return pcall(require, module)
end
local function restart_neovim()
  return vim.api.nvim_cmd({cmd = "restart", args = {":qall!"}}, {})
end
local function quit_neovim()
  return vim.api.nvim_cmd({cmd = "q"}, {})
end
local function start_makyo()
  return require("makyo-fnl.init")
end
local function plugins_already_installed_3f()
  local dir_count = #vim.fn.globpath(lazy_base_path, "*", 0, 1)
  return (dir_count > 4)
end
local function files_already_compiled_3f()
  return vim.uv.fs_stat((nvim_config_lua_path .. "/makyo-fnl"))
end
local function clone_repo(repo_url, _3fbranch, dest)
  return vim.system({"git", "clone", "--filter=blob:none", repo_url, ("--branch=" .. (_3fbranch or "master")), dest}):wait()
end
local function embed_nfnl()
  return vim.system(vim.system(vim.system(vim.system({"cp", "-r", (nfnl_path .. "/lua/nfnl"), nvim_config_lua_path}):wait(), {"mkdir", "-p", (nvim_fnl_path .. "/nfnl/macros")}):wait(), {"cp", (nfnl_path .. "/fnl/macros/aniseed.fnlm"), (nvim_fnl_path .. "/nfnl/macros/")}), {"cp", (nfnl_path .. "/fnl/macros.fnlm"), (nvim_fnl_path .. "/nfnl")})
end
local function bootstrap_lazy()
  if not vim.uv.fs_stat(lazy_path) then
    clone_repo("https://github.com/folke/lazy.nvim.git", "stable", lazy_path)
  else
  end
  return vim.opt.rtp:prepend(lazy_path)
end
local function bootstrap_nfnl()
  if not is_installed_3f("nfnl.core") then
    clone_repo("https://github.com/Olical/nfnl", "main", nfnl_path)
    embed_nfnl()
  else
  end
  return vim.opt.rtp:prepend(nfnl_path)
end
local function bootstrap_nvim_lua()
  if not is_installed_3f("nvim") then
    clone_repo("https://github.com/norcalli/nvim.lua", nvim_lua_path)
  else
  end
  return vim.opt.rtp:prepend(nvim_lua_path)
end
local function bootstrap()
  bootstrap_lazy()
  bootstrap_nfnl()
  return bootstrap_nvim_lua()
end
local function start_app()
  vim.api.nvim_exec_autocmds({"User"}, {group = makyo_start_augroup, pattern = "LazyDone"})
  return vim.print("[makyo] \240\159\148\140 Plugins setup completed.")
end
local function restore_plugins()
  local lazy = require("lazy")
  local _let_4_ = require("nfnl.api")
  local compile_all_files = _let_4_["compile-all-files"]
  if not files_already_compiled_3f() then
    compile_all_files(nvim_config_path)
    vim.print("[makyo] \240\159\148\140 Compilation completed successfully.")
    restart_neovim()
  else
  end
  if plugins_already_installed_3f() then
    lazy.setup("makyo-fnl.plugins.lazy.plugins", {wait = true})
  else
  end
  if not plugins_already_installed_3f() then
    lazy.setup("makyo-fnl.plugins.lazy.plugins", {wait = true})
    return lazy.restore({wait = true, show = true})
  else
    return nil
  end
end
local function prepare_lazy_done_hook()
  local startup_augroup = makyo_start_augroup
  return vim.api.nvim_create_autocmd({"User"}, {group = startup_augroup, pattern = "LazyDone", callback = start_makyo})
end
local function init()
  bootstrap()
  prepare_lazy_done_hook()
  restore_plugins()
  return start_app()
end
return init()
