(import-macros {: module
                : def
                }
                :nfnl.macros.aniseed)

(module makyo-fnl.plugins.lazy.plugins.application)

(local {: spec} (require :makyo-fnl.plugins.lazy.spec))

(def application-plugins
  [
   "Apeiros-46B/qalc.nvim"
   "simnalamburt/vim-mundo"
   "acustodioo/vim-tmux"
   "DAmesberger/sc-im.nvim"

   (spec "voldikss/vim-floaterm" {:init #(set vim.g.floaterm_rootmarkers [".git" ".gitignore"])})

   (spec "lbrayner/vim-rzip" {:lazy true})

   ;; Paste images from system clipboard
   (spec "HakonHarnes/img-clip.nvim" {:event "VeryLazy"})
   ])

;; Export them
application-plugins
