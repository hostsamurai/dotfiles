(module makyo-fnl.plugins
  {require {a aniseed.core
            fzf makyo-fnl.plugins.fzf}})

(defn init []
  (do 
    (fzf.init)))
