(import-macros {: module
                : def
                }
                :nfnl.macros.aniseed)

(module makyo-fnl.plugins.which-key.layers.normal.buffer)

(def buffer-layer
  {
   :b {
       :name "+buffer"
       :b ["<cmd>FzfBuffers<cr>"          "find buffer"]
       :d ["<cmd>bd<cr>"                  "delete buffer"]
       :D ["<cmd>bd!<cr>"                 "force delete buffer"]
       :h [#(vim.api.nvim_exec2 "tabnew | Startify" true) "home buffer"]
       :m ["<cmd>BufExplorer<cr>"         "manage buffers"]
       :p ["<cmd>bprevious<cr>"           "previous buffer"]
       :s ["<cmd>Scratch<cr>"             "scratch buffer"]
       ;; Maps to <TAB>. See :help keycodes
       "<Tab>" ["<cmd>b#<cr>"             "previous buffer"]
       }
   })
