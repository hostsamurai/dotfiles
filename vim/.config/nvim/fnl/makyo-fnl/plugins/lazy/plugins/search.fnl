(import-macros {: module
                : def
                }
                :nfnl.macros.aniseed)

(module makyo-fnl.plugins.lazy.plugins.search)

(def search-plugins
  [
   "jremmen/vim-ripgrep"
   "bronson/vim-visual-star-search"
   "Lokaltog/vim-easymotion"
   "MagicDuck/grug-far.nvim"
  ])

;; Export them
search-plugins
