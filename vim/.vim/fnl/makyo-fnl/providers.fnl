(module makyo-fnl.providers
  {require {a aniseed.core
            nvim aniseed.nvim}})

(defn init []
  "Set up providers to support remote plugins."
  (do 
    (set nvim.g.node_host_prog "/$HOME/.volta/tools/image/packages/neovim/4.9.0/bin/cli.js")
    (set nvim.g.loaded_python_provider 0)
    (set nvim.g.python3_host_prog "/usr/bin/python"))) 
