(module makyo-fnl.plugins
  {require {a aniseed.core
            lb makyo-fnl.plugins.bootstrap
            lazy makyo-fnl.plugins.lazy
            which-key makyo-fnl.plugins.which-key
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
    (which-key.setup-mappings)

   (a.println "[makyo] 🔌 Done.")))
