(import-macros {: module
                : def}
               :nfnl.macros.aniseed)

(module :makyo-fnl.plugins.lazy.plugins.coding)

(local {: update} (require :nfnl.core))
(local utils (require :makyo-fnl.utils))
(local {: spec} (require :makyo-fnl.plugins.lazy.spec))
(local {: setup-completion-sources} (require :makyo-fnl.lsp))

(def coding-plugins
  [
   (spec "L3MON4D3/LuaSnip"
         {
          :version "v2.*"
          :buld "make install_jsregexp"
          :dependencies ["rafamadriz/friendly-snippets" "honza/vim-snippets" "hrsh7th/nvim-cmp"]
          })

   (spec "honza/vim-snippets" {:config (fn []
                                         (let [loader (utils.safe-require "luasnip.loaders.from_snipmate")]
                                           (loader.lazy_load)
                                           (loader.lazy_load {:paths "./snippets"})))})

   ;; All nvim-cmp sources must be referenced first
   (spec "hrsh7th/cmp-nvim-lsp" {:dependencies "hrsh7th/nvim-cmp"})
   (spec "hrsh7th/cmp-nvim-lsp-signature-help" {:dependencies "hrsh7th/nvim-cmp"})
   (spec "hrsh7th/cmp-nvim-lsp-document-symbol" {:dependencies "hrsh7th/nvim-cmp"})
   (spec "onsails/lspkind.nvim" {:dependencies "hrsh7th/nvim-cmp"})
   (spec "hrsh7th/cmp-buffer" {:dependencies "hrsh7th/nvim-cmp"})
   (spec "hrsh7th/cmp-path" {:dependencies "hrsh7th/nvim-cmp"})
   (spec "hrsh7th/cmp-cmdline" {:dependencies "hrsh7th/nvim-cmp"})
   (spec "L3MON4D3/LuaSnip" {:dependencies "hrsh7th/nvim-cmp"})
   (spec "saadparwaiz1/cmp_luasnip" {:dependencies "hrsh7th/nvim-cmp"})
   (spec "SirVer/ultisnips" {:dependencies "hrsh7th/nvim-cmp"})
   (spec "quangnguyen30192/cmp-nvim-ultisnips" {:dependencies "hrsh7th/nvim-cmp"})
   (spec "davidsierradz/cmp-conventionalcommits" {:dependencies "hrsh7th/nvim-cmp"})
   (spec "yus-works/csc.nvim" {:dependencies "hrsh7th/nvim-cmp"})
   (spec "chrisgrieser/cmp-nerdfont" {:dependencies "hrsh7th/nvim-cmp"})
   (spec "hrsh7th/cmp-emoji" {:dependencies "hrsh7th/nvim-cmp"})
   (spec "tamago324/cmp-zsh" {:dependencies "hrsh7th/nvim-cmp"})
   (spec "lukas-reineke/cmp-rg" {:dependencies "hrsh7th/nvim-cmp"})
   (spec "petertriho/cmp-git" {:dependencies "hrsh7th/nvim-cmp"})
   (spec "roginfarrer/cmp-css-variables" {:dependencies "hrsh7th/nvim-cmp"})
   (spec "epwalsh/obsidian.nvim" {:dependencies "hrsh7th/nvim-cmp"})
   (spec "SergioRibera/cmp-dotenv" {:dependencies "hrsh7th/nvim-cmp"})
   (spec "hrsh7th/cmp-nvim-lua" {:dependencies "hrsh7th/nvim-cmp"})

   (spec "hrsh7th/nvim-cmp"
         {:config #(let [cmp (utils.safe-require :cmp)
                         lspkind (utils.safe-require :lspkind)
                         ls (utils.safe-require :luasnip)
                         git (utils.safe-require :cmp_git)
                         csc (utils.safe-require :csc)
                         ap (utils.safe-require :nvim-autopairs.completion.cmp)
                         capabilities (utils.safe-require :cmp_nvim_lsp)]
                     (git.setup)
                     (csc.setup)
                     (cmp.setup {
                                 :snippet {:expand (fn [args]
                                                     (ls.lsp_expand args.body))}
                                 :buffer {:sources (cmp.config.sources [{:name "conventionalcommits"}] [{:name "buffer"}])}
                                 :cmdline {:mapping (cmp.mapping.preset.cmdline) :sources [{:name ["buffer"]}]}
                                 :sources [
                                           {:name "nvim_lsp"}
                                           {:name "nvim_lsp_signature_help"}
                                           {:name "nvim_lsp_document_symbol"}
                                           {:name "buffer" :option {:get_bufnrs #(vim.api.nvim_list_bufs)}}
                                           {:name "luasnip" :option {:show_autosnippets true}}
                                           {:name "nerdfont"}
                                           {:name "emoji"}
                                           {:name "path"}
                                           {:name "zsh"}
                                           {:name "rg"}
                                           {:name "git"}
                                           {:name "css-variables"}
                                           {:name "dotenv"}
                                           {:name "nvim_lua"}
                                           ]
                                 :mapping {
                                           ;; Snippets
                                           "<CR>" (cmp.mapping (fn [fallback]
                                                                 (if (cmp.visible)
                                                                   (if (ls.expandable)
                                                                     (ls.expand)
                                                                     (cmp.confirm {:select true}))
                                                                   (fallback))))
                                           "<Tab>" (cmp.mapping (fn [fallback]
                                                                  (if (cmp.visible)
                                                                    (cmp.select_next_item)
                                                                    (ls.locally_jumpable 1)
                                                                    (ls.jump 1)
                                                                    (fallback)) ["i" "s"]))
                                           "<S-Tab>" (cmp.mapping (fn [fallback]
                                                                    (if (cmp.visible)
                                                                      (cmp.select_prev_item)
                                                                      (ls.locally_jumpable -1)
                                                                      (ls.jump -1)
                                                                      (fallback)) ["i" "s"]))}
                                 :formatting {:format (fn [entry vim_item]
                                                        (vim.print entry.source.name)
                                                        (when (vim.tbl_contains ["path"] entry.source.name)
                                                          (let [devicons (utils.safe-require :nvim-web-devicons)
                                                                {: label} (devicons.get_icon (entry:get_completion_item))
                                                                {: icon : hl_group} label]
                                                            (update vim_item :kind icon)
                                                            (update vim_item :kind_hl_group hl_group)
                                                            (lua "return vim_item")))
                                                        (let [fmt_fn (lspkind.cmp_format {:with_text false})] (fmt_fn entry vim_item)))}
                                 })
                     (cmp.setup.filetype "gitcommit" {:sources [
                                                                {:name "csc"}
                                                                {:name "luasnip"}
                                                                {:name "conventionalcommits"}
                                                                ]})
                     (setup-completion-sources (capabilities.default_capabilities))
                     (cmp.event:on "confirm_done" ap.on_confirm_done))})

   (spec "windwp/nvim-autopairs"
         {:event "InsertEnter"
          :config #(let [ap (utils.safe-require :nvim-autopairs)]
                     (ap.setup {:enable_check_bracket_line false :fast-wrap {
                                                                             :map "<M-e>"
                                                                             :chars: [
                                                                                      "{"
                                                                                      "["
                                                                                      "("
                                                                                      "\""
                                                                                      "'"
                                                                                      ]
                                                                             :pattern "[=[[%'%\"%>%]%)%}%,]]=]"
                                                                             :end_key "$"
                                                                             :before_key "h"
                                                                             :after_key "l"
                                                                             :cursor_pos_before true
                                                                             :keys "qwertyuiopzxcvbnmasdfghjkl"
                                                                             :manual_position true
                                                                             :highlight "Search"
                                                                             :highlight_grey "Comment"}}))})

   "jsfaint/gen_tags.vim"
   "liuchengxu/vista.vim"

   "Shougo/context_filetype.vim"

   (spec "nvim-mini/mini.nvim" {:version "*"
                                :priority 51
                                :config #(let [minifiles (utils.safe-require "mini.files")
                                               minisessions (utils.safe-require "mini.sessions")]
                                           (do
                                             (minifiles.setup)
                                             (minisessions.setup {:directory (.. (vim.fn.stdpath "data") "/sessions")})
                                             ;; Expose `MiniSessions` outside of the `:lua` context.
                                             (set vim.g.makyo_sessions minisessions)))})

   (spec "numToStr/Comment.nvim" {:lazy false})

   (spec "scrooloose/nerdcommenter" {:disable true
                                     :init #(do
                                              (set vim.g.NERDSpaceDelim 0)
                                              (set vim.g.NERDTrimTrailingWhitespace 1))})

   (spec "dense-analysis/ale" {:init #(do
                                        (set vim.g.airline#extensions#ale#enabled 1)
                                        (set vim.g.ale_disable_lsp 1)
                                        (set vim.g.ale_set_balloons 1)
                                        (set vim.g.ale_fix_on_save 1)
                                        (set vim.g.ale_fixers {:javascript ["prettier" "eslint"]
                                                               :* ["remove_trailing_lines" "trim_whitespace"]}))})

   (spec "editorconfig/editorconfig-vim" {:init #(do
                                                   (set vim.g.EditorConfig_exclude_patterns  ["fugitive://.*"])
                                                   (set vim.g.EditorConfig_core_mode "external_command"))})

   "tpope/vim-endwise"
   "tpope/vim-classpath"
   "tpope/vim-repeat"
   "amix/open_file_under_cursor.vim"
   "tpope/vim-dispatch"
   "vim-test/vim-test"
   "tpope/vim-projectionist"

   (spec "rrethy/vim-hexokinase" {:build "make hexokinase"
                                  :init #(do
                                           (set vim.g.all_hexokinase_patterns  [
                                                                                "full_hex"
                                                                                "triple_hex"
                                                                                "rgb"
                                                                                "rgba"
                                                                                "hsl"
                                                                                "hsla"
                                                                                ])
                                           (set vim.g.Hexokinase_ftOptInPatterns  {
                                                                                   :css      vim.g.all_hexokinase_patterns
                                                                                   :less     vim.g.all_hexokinase_patterns
                                                                                   :scss     vim.g.all_hexokinase_patterns
                                                                                   :sass     vim.g.all_hexokinase_patterns
                                                                                   :clojure  "full_hextriple_hexhslhsla"
                                                                                   })
                                           (set vim.g.Hexokinase_ftEnabled   ["css" "less" "sass" "scss" "clojure"])
                                           (set vim.g.Hexokinase_ftDisabled  ["help"]))})

   "mattn/emmet-vim"

   ;; Devcontainer support
   (spec "https://codeberg.org/esensar/nvim-dev-container" {:dependencies "nvim-treesitter/nvim-treesitter"
                                                            :config #(let [devcontainer (utils.safe-require "devcontainer")]
                                                                       (devcontainer.setup {:generate_commands true}))})

   ;; AI
   (spec "greggh/claude-code.nvim" {:dependencies "nvim-lua/plenary.nvim"
                                    :config #(let [claude-code (require :claude-code)]
                                               (claude-code.setup {}))})
   (spec "ravitemer/mcphub.nvim" {:dependencies "nvim-lua/plenary.nvim"
                                  :build "npm install -g mcp-hub@latest"
                                  :config #(let [mcphub (require :mcphub)]
                                             (mcphub.setup {}))})
   (spec "github/copilot.vim" {:lazy false})
   (spec "CopilotC-Nvim/CopilotChat.nvim" {:dependencies "nvim-lua/plenary.nvim"
                                           :build "make tiktoken"})
   ])

;; Export them
coding-plugins
