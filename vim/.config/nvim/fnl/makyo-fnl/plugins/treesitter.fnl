;;; Configures everything dealing with Treesitter
(import-macros {: module
                : def
                : defn-
                : defn
                }
                :nfnl.macros.aniseed)

(module makyo-fnl.plugins.treesitter)

(local {: println} (require :nfnl.core))
(local utils (require :makyo-fnl.utils))


;;; -------------------------------------------------------------------
;;; Configuration Functions


(defn- highlight [bufnr lang]
  (if (not (vim.treesitter.language.add lang))
    (vim.notify (.. "Treesitter cannot load parser for language: " lang)
                vim.log.levels.INFO
                {:title "Treesitter"})
    (vim.treesitter.start bufnr)))

(defn- configure-folds [ft]
  (if (or (= ft "javascriptreact") (= ft "typescriptreact"))
    (set vim.opt_local.foldmethod "indent")
    (do
      (set vim.opt_local.foldmethod "expr")
      (set vim.opt_local.foldexpr "v:lua.vim.treesitter.foldexpr()")))
  (vim.schedule #(if (not (= (vim.fn.mode) "t"))
                    (vim.api.nvim_cmd {:cmd "silent! normal! zx"} ))))

(defn- configure-indent [ft]
  (if (not (contains? ft [:python :html :yaml :markdown]))
    (set vim.bo.indentexpr "v:lua.require('nvim-treesitter').indentexpr()")))

(defn- configure-parsers [ts ft buf]
  (if (contains? (ts.get_installed) ft)
      (highlight buf ft)
      (contains? (ts.get_available) ft)
      (-> (ts.install ft)
          (: :await #(highlight ft)))))

(defn- setup-treesitter-for-filetype [args]
  (let [ft vim.bo.filetype
        bt vim.bo.buftype
        buf args.buf
        ts (utils.safe-require :nvim-treesitter)]
    (when (not (= bt ""))
      (configure-folds ft)
      (configure-indent ft)
      (configure-parsers ts ft buf))))


;;; -------------------------------------------------------------------
;;; Setup


(defn- setup []
  "Configures treesitter"
  (let [ts (utils.safe-require :nvim-treesitter)
        ensure-installed ["lua"
                          "luadoc"
                          "luap"
                          "vim"
                          "vimdoc"
                          "clojure"
                          "commonlisp"
                          "fennel"
                          "racket"
                          "javascript"
                          "typescript"
                          "markdown"
                          "markdown_inline"
                          "http"
                          "html"
                          "css"
                          "scss"
                          "ruby"
                          "jq"
                          "toml"
                          "yaml"
                          "zsh"
                          ]]
    (do
      (ts.setup {:autotag {:enable true}})
      (ts.install ensure-installed)
      (vim.api.nvim_create_autocmd [:FileType]
                                   {:pattern ["<filetype>"]
                                    :group (vim.api.nvim_create_augroup "treesitter.setup" {})
                                    :callback setup-treesitter-for-filetype
                                    }))))

(defn init []
  (do
    (println "[makyo][plugins][treesitter] Setting up ...")
    (setup)
    (println "[makyo][plugins][treesitter] Done.")))
