(import-macros {: module
                : def}
               :nfnl.macros.aniseed)

(module makyo-fnl.plugins.which-key.layers.visual.modes)

(local nvim (require :nvim))

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
