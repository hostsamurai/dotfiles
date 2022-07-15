(module makyo-fnl.plugins
  {require {a aniseed.core
            plugins makyo-fnl.plugins.setup
            fzf makyo-fnl.plugins.fzf}})

(defn init []
  (do 
    (a.println "[makyo] 🔌 Initializing plugins...")

    (plugins.init)
    (fzf.init)

    (a.println "[makyo] 🔌 Done.")))
