(import-macros {
                : module
                : defn-
                : def
                }
                :nfnl.macros.aniseed)

(module :makyo-fnl.plugins.which-key.layers.normal.insertion)
(local {: get-luasnip-loaders : get-luasnip} (require :makyo-fnl.plugins.luasnip))

(def insertion-layer
  {
   :i {
       :name "+insertion"
       :s {
           :name "+snippets"
           :e ["<cmd>LuaSnipEdit<cr>" "edit snippets"]
           :l [#(let [ls (get-luasnip)]
                  ;; TODO: This returns a table containing all metadata related to
                  ;; available snippets. We need to extract the trigger and the
                  ;; description, then show it in some meaningful way. Perhaps using
                  ;; FzfLua or Snacks notify?
                  (ls.get_snippets)) "list snippets"]
           :L [#(let [ls (get-luasnip)]
                  (ls.log.open)) "open snippet log"]}
       }
   })
