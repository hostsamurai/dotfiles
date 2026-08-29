(import-macros {
                : module 
                : defn
                : def
                } :nfnl.macros.aniseed)

(module :config.highlights)

(defn init []
      (vim.api.nvim_create_autocmd "ColorScheme" 
                                   {:callback #(vim.api.nvim_set_hl 0 "@string_key" {:fg "#FFB347"}) 
                                    :group (vim.api.nvim_create_augroup "MyHighlights" {})}))
