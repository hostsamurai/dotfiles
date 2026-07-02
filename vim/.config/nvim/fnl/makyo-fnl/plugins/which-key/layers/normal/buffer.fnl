(import-macros {
                : module
                : def
                : defn-
                }
                :nfnl.macros.aniseed)

(module :makyo-fnl.plugins.which-key.layers.normal.buffer)

(defn- get-snacks []
  (let [Snacks (require :snacks)]
    Snacks))

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
       :s {
           :name "+scratch"
           :b [#(let [Snacks (get-snacks)]
                  (Snacks.scratch))                    "empty scratch buffer"]
           :m [#(let [Snacks (get-snacks)]
                  (Snacks.scratch {:ft "markdown"})) "empty Markdown buffer"]
           :s [#(let [Snacks (get-snacks)]
                  (Snacks.scratch.select))             "select scratch buffer"]
           }
       ;; Maps to <TAB>. See :help keycodes
       "<Tab>" ["<cmd>b#<cr>"             "previous buffer"]
       }
   })
