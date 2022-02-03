(module makyo-fnl.providers
  {require {a aniseed.core
            nvim aniseed.nvim}})

(defn init []
  "Set up providers to support remote plugins."
  (do 
    (set nvim.g.node_host_prog "/$HOME/.volta/tools/image/packages/neovim/bin/neovim-node-host")
    (set nvim.g.loaded_python_provider 0)
    (if (= (nvim.fn.system "uname") "Linux")
      (set nvim.g.python3_host_prog "/usr/bin/python")
      (set nvim.g.python3_host_prog "/usr/local/bin/python")))) 
