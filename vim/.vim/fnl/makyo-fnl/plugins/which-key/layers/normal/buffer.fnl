(module makyo-fnl.plugins.which-key.layers.normal.buffer
    {require {nvim aniseed.nvim}})

(def buffer-layer
  {
   :b {
       :name "+buffer"
       :b ["<cmd>FzfBuffers<cr>"          "find buffer"]
       :d ["<cmd>bd<cr>"                  "delete buffer"]
       :D ["<cmd>bd!<cr>"                 "force delete buffer"]
       :h [#(nvim.exec "tabnew | Startify" true) "home buffer"]
       :m ["<cmd>BufExplorer<cr>"         "manage buffers"]
       :p ["<cmd>bprevious<cr>"           "previous buffer"]
       :s ["<cmd>Scratch<cr>"             "scratch buffer"]
       ;; Maps to <TAB>. See :help keycodes
       "<Tab>" ["<cmd>b#<cr>"             "previous buffer"]
       }
   })
