(import-macros {
                : module
                : defn-
                : defn
                : def
                }
                :nfnl.macros.aniseed)

(module :makyo-fnl.lsp)

(local {: reduce : concat} (require :nfnl.core))
(local fnl-ls (require :makyo-fnl.plugins.lsp.fennel-language-server))
(local ghostty-ls (require :makyo-fnl.plugins.lsp.ghostty-ls))

(defn- get-enabled-lsp-servers []
  (reduce (fn [acc server-info]
            (let [{: name} server-info]
              (concat acc [name])))
          []
          (vim.lsp.get_configs {:enabled true})))

(defn setup-completion-sources [capabilities]
  (let [lsp-servers (get-enabled-lsp-servers)]
    (each [_ server (ipairs lsp-servers)]
      (vim.lsp.config server {:capabilities capabilities})
      (vim.lsp.enable server))))

(defn init []
  (fnl-ls.init)
  (ghostty-ls.init))
