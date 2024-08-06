(module makyo-fnl.plugins
  {require {a aniseed.core
            lb makyo-fnl.plugins.bootstrap
            lazy makyo-fnl.plugins.lazy
            fzf makyo-fnl.plugins.fzf
            treesitter makyo-fnl.plugins.treesitter
            neorg makyo-fnl.plugins.neorg}})

(defn init []
  (do
    (a.println "[makyo] 🔌 Initializing plugins...")

    (lb.bootstrap)
    (lazy.init)
    (fzf.init)
    (treesitter.init)
    (neorg.init)

   (a.println "[makyo] 🔌 Done.")))
