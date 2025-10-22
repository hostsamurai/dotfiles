(module makyo-fnl.plugins.which-key.layers.visual.modes
    {require {nvim aniseed.nvim}})

(def visual-modes-layer
  {
   :m {
       :name "+modes"
       :l {:name "+lisp"
           :e {
               :name "+eval"
               :E [#(nvim.ex.execute "'normal gv' . g:maplocalleader . 'E'") "eval selection"]
               :w [#(nvim.ex.execute "'normal gv' . g:maplocalleader . 'Eiw'") "eval word"]
               }
           }
       }
   })
