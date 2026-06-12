(import-macros {: defn} :nfnl.macros.aniseed)

(local {: println} (require :nfnl.core))
(local config (require :nfnl.config))

(defn init []
  (config.default {:rtp-patterns [".*"]}))

(init)
