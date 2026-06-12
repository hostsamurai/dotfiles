(import-macros {: module
                : def
                : defn}
               :nfnl.macros.aniseed)

(module makyo-fnl.plugins)

(local which-key (require :makyo-fnl.plugins.which-key))
(local treesitter (require :makyo-fnl.plugins.treesitter))
(local fzf (require :makyo-fnl.plugins.fzf))

(local {: println} (require :nfnl.core))

(defn init []
  (do
    (println "[makyo] 🔌 Initializing plugins...")

    (which-key.setup-mappings)
    (treesitter.init)
    (fzf.init)

    (println "[makyo] 🔌 Done.")))
