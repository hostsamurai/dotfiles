(module makyo-fnl.plugins.which-key.layers.normal.insertion)

(def insertion-layer
  {
   :i {
       :name "+insertion"
       :s {
           :name "+snippets"
           :c ["<cmd>CocCommand snippets.openSnippetFiles<cr>" "open snippets file"]
           :e ["<cmd>CocCommand snippets.editSnippets<cr>"     "edit snippets"]
           :l ["<cmd>CocList snippets<cr>"                     "list snippets"]
           }
       }
   })
