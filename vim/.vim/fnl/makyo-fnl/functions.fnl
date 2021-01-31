;;;; General functions used in user commands
(module makyo-fnl.functions
  {require {a aniseed.core
            nvim aniseed.nvim}})

(defn- create_scratch_buffer []
  "Opens a scratch buffer in a new tab"
  (nvim.command "tabnew scratch | setlocal buftype=nofile bufhidden=hide noswapfile"))

(defn init []
  (do 
    (a.println "[makyo] 🚥 Initializing helper functions and commands...")
    (vimp.map_command "Scratch" create_scratch_buffer)
    (a.println "[makyo] 🚥 Done.")))
