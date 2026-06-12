(import-macros {: module
                : def}
                :nfnl.macros.aniseed)

(module makyo-fnl.plugins.which-key.layers.normal.comment-and-compile)

(def comment-and-compile-layer
  {
   :c {
       :name "+comments/compile"
       :c ["<plug>NERDCommenterToggle"    "comment one line"]
       :s ["<plug>NERDCommenterSexy"      "comment sexily"]
       :u ["<plug>NERDCommenterUncomment" "uncomment"]
       }
   })
