(import-macros {
                : module
                : defn-
                : def
                }
                :nfnl.macros.aniseed)

(module makyo-fnl.plugins.which-key.layers.normal.insertion)

(defn- get-luasnip-loaders []
  (let [ls (require :luasnip.loaders)]
    ls))

(defn- get-luasnip []
  (let [ls (require :luasnip)]
    ls))

(def insertion-layer
  {
   :i {
       :name "+insertion"
       :s {
           :name "+snippets"
           :e [#(let [ls (get-luasnip-loaders)]
                  (ls.edit_snippet_files))       "edit snippets"]
           :l [#(let [ls (get-luasnip)]
                  (ls.available))                "available snippets"]
           }
       }
   })
