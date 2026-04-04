(module makyo-fnl.plugins.which-key.layers.normal.toggles)

(def toggles-layer
  {
  :t {
      :name "+toogles"
      :c ["<cmd>FzfColors<cr>" "cycle color schemes"]
      :i {
          :name "+indent"
          :e ["<cmd>IndentEnable<cr>"  "enable indent lines"]
          :d ["<cmd>IndentDisable<cr>" "disable indent lines"]
          :t ["<cmd>IndentToggle<cr>"  "toggle indent lines"]
          }
      }
  })
