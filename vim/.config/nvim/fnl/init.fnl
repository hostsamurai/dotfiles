(import-macros {: defn : def} :nfnl.macros.aniseed)

(local {: println} (require :nfnl.core))
(local config (require :nfnl.config))

(defn init []
  (config.default {:rtp-patterns [".*"]}))

(init)
