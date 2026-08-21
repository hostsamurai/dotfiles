(import-macros {: module} :nfnl.macros.aniseed)

(module :plugins.lsp)

(local {: spec} (require :utils.spec))

[
 ;; LazyVim overrides 
 (spec "mason-org/mason.nvim" 
       {:opts {:ensure_installed [
                                  "lua-language-server"
                                  "luafmt"
                                  "vim-language-server"
                                  "clojure-lsp"
                                  "clj-kondo"
                                  "fennel-ls"
                                  "julia-lsp"
                                  "tsc"
                                  "markdown-oxide"
                                  "htmx-lsp"
                                  "htmlhint"
                                  "css-lsp"
                                  "css-variables-language-server"
                                  "cssmodules-language-server"
                                  "tailwindcss-language-server"
                                  "some-sass-language-server"
                                  "custom-elements-languageserver"
                                  "emmet-language-server"
                                  "harper-ls"
                                  "json-lsp"
                                  "kakehashi" ;; possible to disable the rest with this on?
                                  "llm-ls"
                                  "marksman" ;; markdown 
                                  "mpls" ;; markdown live previews
                                  "postgres-language-server"
                                  "quick-lint-js"
                                  "rubocop"
                                  "ruby-lsp"
                                  "sqls" ;; sql
                                  "superhtml"
                                  "wc-language-server" ;; web components
                                  "wasm-language-tools"
                                  "jq-lsp"
                                  "ts_query_ls"
                                  "yaml-language-server"
                                  "yamlfmt"
                                  "stylelint-language-server"
                                  ]}})
  
 ;; Set up custom LSPs
 (spec "neovim/nvim-lspconfig"
       {:opts {:servers {
                         :racket-langserver {
                                             :name "racket_langserver" 
                                             :cmd ["racket" "-l" "racket-langserver"] 
                                             :filetypes ["racket"]
                                             } 
                         :scheme-lsp-server {
                                             :name "scheme_lsp_server"  
                                             :cmd ["chicken-lsp-server" "--port" "4242"] 
                                             :filetypes ["chicken" "scheme"]
                                             }
                         :cl-lsp {
                                  :name "cl_lsp" 
                                  :cmd ["cl-lsp"] 
                                  :filetypes ["cl" "lisp"]
                                  }
                         }}})
 ]
