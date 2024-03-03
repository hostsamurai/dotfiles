(module nvim-config
  {require {nvim aniseed.nvim}})

(def config-path (nvim.fn.stdpath "config"))

(defn init []
  "Aniseed causes the Fennel source code to be compiled to Lua within
  the `lua/` directory where the Neovim config directory resides. This
  function retrieves the compiled initialization script which in turn
  loads and executes the different modules associated with Makyo. The
  aforementioned initialization script resides in
  `fnl/makyo-fnl/init.fnl`."
  (let [init-path (.. config-path "/lua/makyo-fnl/init.lua")
        lua-init-path (string.gsub init-path ".*/(.-)/(.-)%.lua" "%1.%2")]
    (require lua-init-path)))

(init)
