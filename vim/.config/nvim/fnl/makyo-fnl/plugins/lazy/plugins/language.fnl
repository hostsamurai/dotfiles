(import-macros {: module
                : def-
                : def}
               :nfnl.macros.aniseed)

(module makyo-fnl.plugins.lazy.plugins.language)

(local {: spec} (require :makyo-fnl.plugins.lazy.spec))
(local utils (require :makyo-fnl.utils))

(def- lsp-ensure-installed [
                            "ast_grep"
                            "bashls"
                            "clojure_lsp"
                            "cssls"
                            "css_variables"
                            "eslint"
                            "fennel_ls"
                            "harper_ls"
                            "htmx"
                            "jsonls"
                            "lua_ls"
                            "mdx_analyzer"
                            "ruby_lsp"
                            "ts_ls"
                            "vtsls"
                            ])

(def language-plugins
  [
   (spec "nvim-treesitter/nvim-treesitter" {:lazy false :build ":TSUpdate"})

   ;; Treesitter support
   "nvim-treesitter/nvim-treesitter-context"
   "windwp/nvim-ts-autotag"

   ;; LSP support
   (spec "neovim/nvim-lspconfig" {:dependencies ["nvimdev/lspsaga.nvim"]})
   (spec "mason-org/mason.nvim" {:config #(let [mason (require :mason)]
                                               (mason.setup))})
   (spec "mason-org/mason-lspconfig.nvim"
         {:dependencies ["mason-org/mason.nvim" "neovim/nvim-lspconfig"]
          :config #(let [mason-config (require :mason-lspconfig)]
                     (mason-config.setup {
                                          :automatic_installation true
                                          :ensure_installed lsp-ensure-installed
                                          }))})
   (spec "WhoIsSethDaniel/mason-tool-installer.nvim"
         {:config #(let [mason-tool-installer (require :mason-tool-installer)]
                     (mason-tool-installer.setup {
                                                  :auto_update true
                                                  :ensure_installed [
                                                                     "ts-standard"
                                                                     "clj-kondo"
                                                                     "cljfmt"
                                                                     "html-lsp"
                                                                     "htmlbeautifier"
                                                                     ]
                                                  }))})
   (spec "nvimdev/lspsaga.nvim"
         {:dependencies ["nvim-treesitter/nvim-treesitter" "nvim-tree/nvim-web-devicons"]
          :config #(let [lspsaga (require :lspsaga)]
                     (lspsaga.setup {}))})

   ;; DSP support
   "mfussenegger/nvim-dap"
   (spec "rcarriga/nvim-dap-ui" {:dependencies "mfussenegger/nvim-dap"})

   ;; Formatting support
   "mhartington/formatter.nvim"

   ;; Ultimate syntax collection
   (spec "sheerun/vim-polyglot"
         {:init (fn []
                    (do
                      (set vim.g.javascript_plugin_jsdoc 1)
                      (set vim.g.jscomplete_use ["dom" "moz" "es6th"])
                      (set vim.g.clojure_align_multiline_strings 0)))})

   "wuelnerdotexe/vim-astro"

   ;; Templating
   "tpope/vim-liquid"

   ;; Clojure
   (spec "tpope/vim-fireplace" {:ft "clojure"})
   (spec "dgrnbrg/vim-redl" {:ft "clojure"})
   (spec "clojure-vim/acid.nvim" {:ft "clojure"})
   (spec "venantius/vim-eastwood" {:ft "clojure"})
   (spec "venantius/vim-cljfmt" {:ft "clojure"})

   ;; Fennel
   "bakpakin/fennel.vim"
   (spec "Olical/nvim-local-fennel" {:enabled false})
   (spec "Olical/nfnl" {:lazy false :priority 999999})
   (spec "Olical/conjure"
         {:ft  ["clojure" "scheme" "racket" "chicken" "fennel"]})

   (spec "kovisoft/paredit"
         {:ft  ["clojure" "scheme" "racket" "chicken" "fennel"]
          :init #(do
                   (set vim.g.paredit_mode 1)
                   (set vim.g.paredit_shortmaps 1)
                   (set vim.g.paredit_smartjump 1)
                   (set vim.g.paredit_leader "\\"))})

   (spec "guileen/vim-node" {:ft "javascript"})
   (spec "myhere/vim-nodejs-complete" {:ft "javascript"})

   (spec "tpope/vim-rails" {:ft  "ruby"})

   ;; Lua
   (spec "nvim-lua/completion-nvim" {:ft "lua"})
   ;; Path context manager unit testing and luarocks installation functions
   "nvim-lua/plenary.nvim"
   (spec "euclidianAce/BetterLua.vim" {:ft "lua"})
   (spec "tjdevries/manillua.nvim" {:ft "lua"})
   (spec "bfredl/nvim-luadev" {:ft "lua"})
   "svermeulen/vimpeccable"

   "vim-pandoc/vim-pandoc"

   ;; Markdown
   (spec "iamcco/markdown-preview.nvim" {:ft ["markdown" "pandoc.markdown" "rmd"]
                                         :build "cd app && yarn install"})
   (spec "davidmh/mdx.nvim" {:dependencies "nvim-treesitter/nvim-treesitter"})
   (spec "MeanderingProgrammer/render-markdown.nvim" {:dependencies ["nvim-treesitter/nvim-treesitter" "nvim-tree/nvim-web-devicons"]
                                                      :config #(let [render-markdown (utils.safe-require "render-markdown")]
                                                                 (render-markdown.setup {:heading {
                                                                                                   :render_modes true
                                                                                                   :border true
                                                                                                   :border_virtual true
                                                                                                   }
                                                                                         :lsp {:enabled true}
                                                                                         :completions {:enabled true}
                                                                                         :indent {:enabled true :skip_heading true}}))})

   ;; Interactive REPL inside the editor
   (spec "pappasam/nvim-repl"
         {:keys [
                 [ "<Leader>c" "<Plug>(ReplSendCell)"   {:mode "n" :desc "Send Repl Cell"} ]
                 [ "<Leader>r" "<Plug>(ReplSendLine)"   {:mode "n" :desc "Send Repl Line"} ]
                 [ "<Leader>r" "<Plug>(ReplSendVisual)" {:mode "x" :desc "Send Repl Visual Selection"} ]
                 ]})

   "yasuhiroki/github-actions-yaml.vim"

   ;; Vim helpers
   (spec "norcalli/nvim.lua" {:priority 999999})
   ])

;; Export them
language-plugins
