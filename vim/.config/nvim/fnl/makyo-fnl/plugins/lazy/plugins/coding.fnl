(import-macros {: module
                : def}
               :nfnl.macros.aniseed)

(module :makyo-fnl.plugins.lazy.plugins.coding)

(local utils (require :makyo-fnl.utils))
(local {: spec} (require :makyo-fnl.plugins.lazy.spec))
(local ls-helper (require :makyo-fnl.plugins.luasnip))

(def coding-plugins
  [
   (spec "L3MON4D3/LuaSnip"
         {
          :version "v2.*"
          :buld "make install_jsregexp"
          :dependencies ["rafamadriz/friendly-snippets" "honza/vim-snippets"]
          :config #(let [ls (utils.safe-require "luasnip")
                         from_snipmate (utils.safe-require "luasnip.loaders.from_snipmate")]
                     (ls-helper.setup ls {:snipmate from_snipmate}))
          })

   (spec "hrsh7th/nvim-cmp"
         {:dependencies [
                         "neovim/nvim-lspconfig"
                         "hrsh7th/cmp-nvim-lsp"
                         "hrsh7th/cmp-buffer"
                         "hrsh7th/cmp-cmdline"
                         "L3MON4D3/LuaSnip"
                         "saadparwaiz1/cmp_luasnip"
                         "SirVer/ultisnips"
                         "quangnguyen30192/cmp-nvim-ultisnips"
                         "davidsierradz/cmp-conventionalcommits"
                         "chrisgrieser/cmp-nerdfont"
                         "hrsh7th/cmp-emoji"
                         "tamago324/cmp-zsh"
                         "lukas-reineke/cmp-rg"
                         "petertriho/cmp-git"
                         "roginfarrer/cmp-css-variables"
                         "epwalsh/obsidian.nvim"
                         "SergioRibera/cmp-dotenv"
                         "hrsh7th/cmp-nvim-lua"
                         ]
          :config #(let [cmp (utils.safe-require "cmp")]
                     (cmp.setup {:snippet {:expand (fn [args]
                                                     (let [ls (utils.safe-require "luasnip")]
                                                       (ls.lsp_expand args.body)))}
                                 :cmdline {:mapping (cmp.mapping.preset.cmdline) :sources [{:name ["buffer"]}]}
                                 :sources [
                                           {:name "nvim_lsp"}
                                           {:name "buffer" :option {:get_bufnrs #(vim.api.nvim_list_bufs)}}
                                           {:name "luasnip"}
                                           {:name "conventionalcommits"}
                                           {:name "nerdfont"}
                                           {:name "emoji"}
                                           {:name "zsh"}
                                           {:name "rg"}
                                           {:name "git"}
                                           {:name "css-variables"}
                                           {:name "dotenv"}
                                           {:name "nvim_lua"}
                                           ]}))})

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
