(module makyo-fnl.plugins
  {require {a aniseed.core
            lb makyo-fnl.plugins.bootstrap
            lazy makyo-fnl.plugins.lazy
            fzf makyo-fnl.plugins.fzf
            treesitter makyo-fnl.plugins.treesitter}})

(defn init []
  (do
    (a.println "[makyo] 🔌 Initializing plugins...")

    (lb.bootstrap)
    (lazy.init)
    (fzf.init)
    (treesitter.init)

   (a.println "[makyo] 🔌 Done.")))
