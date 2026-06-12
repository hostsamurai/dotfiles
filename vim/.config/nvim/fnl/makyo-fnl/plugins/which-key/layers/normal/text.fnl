(import-macros {: module
                : def}
                :nfnl.macros.aniseed)

(module makyo-fnl.plugins.which-key.layers.normal.text)

(def text-layer
  {
   :x {
       :name "+text"
       :a ["<cmd>EasyAlign<cr>"     "align text"]
       :l ["<cmd>LiveEasyAlign<cr>" "align text w/ live preview"]
       :t {
           :name "+table-mode"
           :f {
               :name "+formulas"
               :e ["<cmd>TableEvalFormulaLine<cr>" "eval formula"]
               :f ["<cmd>TableAddFormula<cr>"      "add cell formula"]
               }
           :r ["<cmd>TableModeRealign<cr>" "realign"]
           :t ["<cmd>TableModeToggle<cr>"  "toggle"]
           }
       }
   })
