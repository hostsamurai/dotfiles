(import-macros {: module
                : def}
               :nfnl.macros.aniseed)

(module :makyo-fnl.plugins.which-key.layers.visual.fzf)

(def visual-fzf-layer
  {
   :F {
       :name "+FZF"
       :g ["<cmd>FzfLua grep_visual<cr>" "search visual selection"]
       :t ["<cmd>FzfLua tags_grep_visual<cr>" "tags_grep visual selection"]
       }
   })
