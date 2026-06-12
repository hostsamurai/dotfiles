(import-macros {: module
                : defn}
               :nfnl.macros.aniseed)

(module makyo-fnl.lsp)

(local fnl-ls (require :makyo-fnl.plugins.lsp.fennel-language-server))

(defn init []
  (fnl-ls.init))
