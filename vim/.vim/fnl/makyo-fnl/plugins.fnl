(module makyo-fnl.plugins
  {require {a aniseed.core
            fzf makyo-fnl.plugins.fzf}})

(defn init []
  (do 
    (a.println "[makyo] 🔌 Initializing plugins...")
    (fzf.init)
    (a.println "[makyo] 🔌 Done.")))
