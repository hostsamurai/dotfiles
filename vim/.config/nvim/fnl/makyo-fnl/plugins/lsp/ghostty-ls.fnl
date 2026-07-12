(import-macros {
                : module
                : defn
                : def
                }
                :nfnl.macros.aniseed)

(module :makyo-fnl.plugins.lsp.ghostty-ls)

(defn init []
  (set vim.lsp.config.ghostty {:cmd "ghostty-ls" :filetypes ["ghostty"]})
  (vim.lsp.enable "fennel_ls"))
