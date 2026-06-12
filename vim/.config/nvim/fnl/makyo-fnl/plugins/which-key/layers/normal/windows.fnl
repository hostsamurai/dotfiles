(import-macros {: module
                : def}
               :nfnl.macros.aniseed)

(module makyo-fnl.plugins.which-key.layers.normal.windows)

(local nvim (require :nvim))

(def windows-layer
  {
   :w {
       :name "+windows"
       :a    ["<cmd>windo q<cr>"                  "close all windows"]
       :s    ["<cmd>exe 'split'<cr>"              "horizontal split"]
       :v    ["<cmd>exe 'vsplit'<cr>"             "vertical split"]
       :c    ["<cmd>close<cr>"                    "close current window"]
       :C    ["<cmd>set cmdheight=2<cr>"          "fix command line height"]
       :f    ["<cmd>wincmd w<cr>"                 "focus current floating window"]
       :k    ["<cmd>KillAllFloatingWindows<cr>"   "kill floating windows"]
       :l    ["<cmd>lopen<cr>"                    "open location list"]
       :q    ["<cmd>copen<cr>"                    "open quickfix"]
       :W    [#(nvim.g.windowpicker.pick_window)  "jump to window"]
       "+"   ["<cmd>resize +5<cr>"                "increase height"]
       "-"   ["<cmd>resize -5<cr>"                "decrease height"]
       }
   })
