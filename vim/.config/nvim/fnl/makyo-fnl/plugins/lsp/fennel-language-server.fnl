(import-macros {: module
                : defn}
               :nfnl.macros.aniseed)

(module makyo-fnl.plugins.lsp.fennel-language-server)

(local vim _G.vim)

(defn init []
  (vim.lsp.enable "fennel_ls"))
