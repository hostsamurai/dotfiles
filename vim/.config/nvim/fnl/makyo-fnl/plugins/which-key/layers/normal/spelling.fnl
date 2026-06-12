(import-macros {: module
                : def}
               :nfnl.macros.aniseed)

(module makyo-fnl.plugins.which-key.layers.normal.spelling)

(local nvim (require :nvim))

(def spelling-layer
  {
   :S {
       :name "+spelling"
       :e ["<cmd>set spell<cr>"   "enable spell checker"]
       :f ["<cmd>set nospell<cr>" "disable spell checker"]
       :n [#(nvim.ex.normal "]s") "next misspelled word"]
       :p [#(nvim.ex.normal "[s") "previous misspelled word"]
       }
   })
