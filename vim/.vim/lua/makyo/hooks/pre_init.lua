------------
--- Runs setup logic before initializing all other modules.
-- @module

local function configure_luarocks_path()
  local home_dir = os.getenv('HOME')

  local paths = {
    local_package_paths = {
      ".luarocks/share/lua/5.1/?.lua;",
      ".luarocks/share/lua/5.1/?/init.lua;;"
    },
    local_package_cpath = ".luarocks/lib/lua/5.1/?.so;;"
  }

  local function prefix_with_home_dir(path) return home_dir .. path end

  local function prepend_local_to_path(path_to_prepend, path)
    if type(path_to_prepend) == 'table' then
      local paths_with_lua_dir_prepended = vim.tbl_map(prefix_with_home_dir, path_to_prepend)
      return table.concat(paths_with_lua_dir_prepended) .. path
    else
      return home_dir .. path_to_prepend .. path
    end
  end

  package.path = prepend_local_to_path(paths.local_package_paths, package.path)
  package.cpath = prepend_local_to_path(paths.local_package_cpath, package.cpath)
end

--- Runs hook logic
-- FIXME: why is opts nil?
local function run(opts)
  print("opts is: " .. vim.inspect(opts))
  if opts.configure_path == true then
    configure_luarocks_path()
  end  
end

return {
  run = run
}
