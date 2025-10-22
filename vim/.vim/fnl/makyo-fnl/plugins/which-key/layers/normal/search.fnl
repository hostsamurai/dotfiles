(module makyo-fnl.plugins.which-key.layers.normal.search
    {require {a aniseed.core
              nvim aniseed.nvim}})

(def search-layer
  {
   :s {
       :name "+search"
       :c ["<cmd>nohlsearch<cr>" "clear highlights"]
       :f ["<cmd>Farf<cr>"       "search with Far"]
       :u [#(nvim.exec (a.str "FzfRRG " (nvim.fn.expand "<cword>")) true) "word under cursor"]
       :s {
           :name "+replace"
           :s ["<cmd>Farr<cr>" "manual replace all"]
           }
       }
   })
