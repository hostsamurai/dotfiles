(module makyo-fnl.plugins.which-key.layers.normal.modes
    {require {nvim aniseed.nvim}})

(def modes-layer
  {
   :m {
       :name "+modes"
       :l {
           :name "+lisp"
           :b [#(nvim.ex.execute "':normal ' . g:maplocalleader . 'eb'") "eval buffer"]
           :e {
               :name "+eval"
               :e  [#(nvim.ex.execute "':normal ' . g:maplocalleader . 'ee'") "inner form"]
               :r  [#(nvim.ex.execute "':normal ' . g:maplocalleader . 'er'") "outer form"]
               "!" [#(nvim.ex.execute "':normal ' . g:maplocalleader . 'e!'") "replace with result"]
               }
           :l {
               :name "+log-buffer"
               :c [#(nvim.ex.execute "':normal ' . g:maplocalleader . 'lq'") "close"]
               :s [#(nvim.ex.execute "':normal ' . g:maplocalleader . 'ls'") "open horizontally"]
               :v [#(nvim.ex.execute "':normal ' . g:maplocalleader . 'lv'") "open vertically"]
               }
           }
       :m {
           :name "+markdown"
           :p ["<cmd>MarkdownPreview<cr>" "preview"]
           }
       :n {
           :name "+nodejs"
           :r ["<cmd>FloatermNew node<cr>" "repl"]
           }
       }
   })
