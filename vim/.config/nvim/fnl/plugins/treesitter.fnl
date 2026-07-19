(import-macros {: module
                : def
                : defn}
               :nfnl.macros.aniseed)

(module :plugins.treesitter)

(local {: merge} (require :nfnl.core))
(local {: spec} (require :utils.spec))

[
 ;; Extend the "ensure_installed" list 
 (spec "nvim-treesitter/nvim-treesitter" {:opts (fn [_ opts]
                                                  (let [ensure-installed (merge opts.ensure_installed [
                                                                                                       "lua"
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
                                                                                                       ])]
                                                    ;; Mutate opts.ensure_installed directly. Otherwise, this 
                                                    ;; setup will not work.
                                                    (set opts.ensure_installed ensure-installed)))})
 ]
