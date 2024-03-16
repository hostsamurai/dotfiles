(module makyo-fnl.plugins.lazy
  {require {a aniseed.core
            nvim aniseed.nvim
            {: trimr} aniseed.string}
   autoload {: lazy
             {: normal-mode-layers
             : visual-mode-layers} makyo-fnl.plugins.which-key}})

(defn- spec [plugin-name spec-definitions]
  "Gets around Fennel's limitation of being unable to mix associative
  and sequential tables by using a sequential table with the plugin
  name as its first element, followed by the rest of the plugin
  definition. This is necessary for Lazy to detect spec definitions
  correctly."
  (a.merge [plugin-name] spec-definitions))

(def- general-purpose-plugins
  [
   (spec "folke/which-key.nvim" {:event "VeryLazy"
                                 :opts {
                                        ;:triggers ["<leader>"]
                                        ;:prefix "<leader>"
                                        :plugins {:presets {
                                                            :operators false
                                                            :motions false
                                                            :nav false
                                                            :z false
                                                            :g false
                                                           }}
                                       }
                                 :init #(let [wk (require :which-key)
                                              svar nvim.set_var]
                                          (do
                                            (set vim.o.timeout true)
                                            (set vim.o.timeoutlen 300)
                                            (svar "mapleader" " ")
                                            (wk.register normal-mode-layers {:prefix "<leader>"})
                                            (wk.register visual-mode-layers {:mode "v" :silent true :noremap true})))})

   "skywind3000/asynctasks.vim"
   ])

(def- coding-plugins
  [
   (spec "neoclide/coc.nvim" {:branch  "release"})

   "jsfaint/gen_tags.vim"
   "liuchengxu/vista.vim"

   "honza/vim-snippets"
   "Shougo/context_filetype.vim"

   (spec "justinmk/vim-dirvish" {:init #(set vim.g.dirvish_mode ":sort ,^.*[\\/],")})
   ;; Show git status flags along Dirvish
   "kristijanhusak/vim-dirvish-git"
   ;; List all files defined by your projections with the Dirvish plugin
   "fsharpasharp/vim-dirvinist"

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
   ])

(def- text-manipulation-plugins
  [
   "terryma/vim-multiple-cursors"
   "t9md/vim-textmanip"
   "tpope/vim-speeddating"
   "tpope/vim-surround"
   "vim-scripts/visincr"

   (spec "losingkeys/vim-niji" {:ft  [
                                      "lisp"
                                      "scheme"
                                      "clojure"
                                      "fennel"
                                      "janet"
                                      ]
                                :init #(set vim.g.niji_matching_filetypes [
                                                                           "lisp"
                                                                           "scheme"
                                                                           "clojure"
                                                                           "fennel"
                                                                           "janet"
                                                                           ])})

   (spec "AndrewRadev/switch.vim" {:cmd "Switch"
                                   ;; TODO: Get rid of this
                                   :init #(set vim.g.switch_mapping  "<Space>tt")})

   "junegunn/vim-easy-align"
   "wellle/targets.vim"
   "rhysd/clever-f.vim"

   (spec "dhruvasagar/vim-table-mode" {:lazy  true
                                       :cmd  ["TableModeToggle" "TableModeEnable" "Tableize"]})

   (spec "dkarter/bullets.vim" {:init #(set vim.g.bullets_set_mappings 0)})
   ])

(def- language-plugins
  [
   (spec "nvim-treesitter/nvim-treesitter" {:build (fn []
                                                     (if (nvim.fn.exists ":TSUpdate")
                                                       (nvim.command "TSUpdate")
                                                       (let [ts-install (require :nvim-treesitter.install)
                                                             ts-update (ts-install.update {:with_sync true})]
                                                         (ts-update))))})

   ;; Treesitter support
   "nvim-treesitter/nvim-treesitter-context"
   "windwp/nvim-ts-autotag"

   ;; LSP support
   "neovim/nvim-lspconfig"
   "williamboman/mason.nvim"
   "williamboman/mason-lspconfig.nvim"
   (spec "nvimdev/lspsaga.nvim" {:dependencies "nvim-lspconfig"
                                 :config #(do
                                            (let [lspsaga (require :lspsaga)]
                                              (lspsaga.setup {})))})

   ;; DSP support
   "mfussenegger/nvim-dap"
   (spec "rcarriga/nvim-dap-ui" {:dependencies "mfussenegger/nvim-dap"})

   ;; Linter support
   (spec "mfussenegger/nvim-lint" {:config #(let [lint (require :lint)]
                                              (set lint.linters_by_ft {
                                                                       :bash       ["shellcheck"]
                                                                       :clojure    ["clj-kondo"]
                                                                       :css        ["stylelint"]
                                                                       :fennel     ["fennel"]
                                                                       :html       ["tidy" "curly"]
                                                                       :javascript ["eslint_d" "jshint"]
                                                                       :json       ["jsonlint"]
                                                                       :markdown   ["vale" "markdownlint"]
                                                                       :ruby       ["rubocop"]
                                                                       :sass       ["stylelint"]
                                                                       :text       ["vale"]
                                                                       :zsh        ["shellcheck"]
                                                                       }))})

   ;; Formatting support
   "mhartington/formatter.nvim"

   ;; Ultimate syntax collection
   (spec "sheerun/vim-polyglot"
         {:config (fn []
                    (do
                      (set vim.g.javascript_plugin_jsdoc 1)
                      (set vim.g.jscomplete_use ["dom" "moz" "es6th"])
                      (set vim.g.clojure_align_multiline_strings 0)))})

   (spec "tpope/vim-fireplace" {:ft "clojure"})
   (spec "dgrnbrg/vim-redl" {:ft "clojure"})
   (spec "clojure-vim/acid.nvim" {:ft "clojure"})

   "bakpakin/fennel.vim"
   (spec "Olical/nvim-local-fennel" {:enabled false})
   "Olical/aniseed"
   (spec "Olical/conjure"
         {:ft  ["clojure" "scheme" "racket" "chicken" "fennel"]
          :init (fn []
                  (set vim.g.conjure#client#fennel#aniseed#aniseed_module_prefix "aniseed."))})

   (spec "kovisoft/paredit"
         {:ft  ["clojure" "scheme" "racket" "chicken" "fennel"]
          :init (fn []
                  (do
                    (set vim.g.paredit_mode 1)
                    (set vim.g.paredit_shortmaps 1)
                    (set vim.g.paredit_smartjump 1)
                    (set vim.g.paredit_leader "")))})

   (spec "guileen/vim-node" {:ft "javascript"})
   (spec "myhere/vim-nodejs-complete" {:ft "javascript"})
   (spec "prettier/vim-prettier"
         {:build "npm install --frozen-lockfile --production"
          :ft [
               "javascript"
               "typescript"
               "typescriptreact"
               "less"
               "css"
               "scss"
               "json"
               "graphql"
               "markdown"
               "yaml"
               "html"
               ]})

   (spec "tpope/vim-rails" {:ft  "ruby"})

   ;; Lua
   "tjdevries/nlua.nvim"
   (spec "nvim-lua/completion-nvim" {:ft "lua"})
   ;; Path context manager unit testing and luarocks installation functions
   "nvim-lua/plenary.nvim"
   (spec "euclidianAce/BetterLua.vim" {:ft "lua"})
   (spec "tjdevries/manillua.nvim" {:ft "lua"})
   (spec "bfredl/nvim-luadev" {:ft "lua"})
   "svermeulen/vimpeccable"

   "teal-language/vim-teal"

   "vim-pandoc/vim-pandoc"

   (spec "iamcco/markdown-preview.nvim" {:ft ["markdown" "pandoc.markdown" "rmd"]
                                         :build "cd app && yarn install"})

   ;; An interactive scratchpad
   "metakirby5/codi.vim"
  ])

(def- application-plugins
  [
   "gregsexton/VimCalc"
   "simnalamburt/vim-mundo"
   "acustodioo/vim-tmux"

   (spec "voldikss/vim-floaterm" {:init #(set vim.g.floaterm_rootmarkers [".git" ".gitignore"])})

   (spec "lbrayner/vim-rzip" {:lazy true})
   ])

(def- version-control-plugins
  [
   ;; Show a sign in the gutter to signify changes
   (spec "mhinz/vim-signify" {:init #(do
                                       (set vim.g.signify_realtime 1)
                                       (set vim.g.signify_vcs_list ["git" "hg"]))})

   ;; Perform various git functions
   (spec "NeogitOrg/neogit" {:dependencies [
                                            "nvim-lua/plenary.nvim"
                                            "sindrets/diffview.nvim"
                                            "ibhagwan/fzf-lua"
                                            ]
                             :config true})

   ;; Open commit messages in a popup window
   (spec "rhysd/git-messenger.vim" {:cmd  "GitMessenger"})

   (spec "samoshkin/vim-mergetool" {:init #(do
                                             (set vim.g.mergetool_layout "LmR")
                                             (set vim.g.mergetool_prefer_revision "local"))})

   "f-person/git-blame.nvim"
   (spec "APZelos/blamer.nvim" {:init #(do
                                         (set vim.g.blamer_show_in_insert_modes 0)
                                         (set vim.g.blamer_show_in_visual_modes  0)
                                         (set vim.g.blamer_relative_time  1))})

   (spec "ruifm/gitlinker.nvim" {:dependencies ["nvim-lua/plenary.nvim"]
                                 :lazy true
                                 :config #(autoload {{: init} gitlinker}
                                                    (init {:mappings nil}))})

   "tyru/open-browser.vim"

   (spec "tyru/open-browser-github.vim" {:dependencies ["tyru/open-browser.vim"]
                                         :init #(set vim.g.openbrowser_github_always_d_branch 1)})
  ])

(def- search-plugins
  [
   "jremmen/vim-ripgrep"
   "bronson/vim-visual-star-search"
   "Lokaltog/vim-easymotion"
   "brooth/far.vim"
  ])

(def- ui-plugins
  [
   (spec "mhinz/vim-startify" {:init #(do
                                        (set vim.g.startify_session_dir "~/.config/nvim/sessions")
                                        (set vim.g.startify_lists [{:type "files"     :header ["   Files"]}
                                                                   {:type "dir"       :header [(let [cwd (vim.fn.getcwd)]
                                                                                                 (.. "   Current Directory " cwd))]}
                                                                   {:type "sessions"  :header ["   Sessions"]}
                                                                   {:type "bookmarks" :header ["   Bookmarks"]}])
                                        (set vim.g.startify_bookmarks [{:I  "~/dotfiles/vim/.vim/init.vim"}
                                                                       {:P  "~/dotfiles/vim/.vim/fnl/makyo-fnl/which-key.fnl"}
                                                                       {:V  "~/dotfiles/vim/.vim/fnl/init.fnl"}
                                                                       {:Z  "~/dotfiles/zsh/.zshrc"}
                                                                       "~/Code"])
                                        (set vim.g.startify_session_persistence 1)
                                        (set vim.g.startify_change_to_vcs_root 0 )
                                        (set vim.g.startify_session_sort 1)
                                        (set vim.g.startify_enable_special 0))})

   "junegunn/fzf"
   (spec "junegunn/fzf.vim" {:init #(set vim.g.fzf_command_prefix "Fzf")})

   (spec "jlanzarotta/bufexplorer" {:lazy true
                                    :init #(set vim.g.bufExplorerDisableDefaultKeyMapping 1)})

   (spec "Yggdroot/indentLine" {:init #(do
                                         (set vim.g.indentLine_fileTypeExclude ["text" "help"])
                                         (set vim.g.indentLine_bufNameExclude ["_.*" "Startify*"])
                                         (set vim.g.indentLine_char "┊"))})

   (spec "tomtom/quickfixsigns_vim" {:init #(set vim.g.quickfixsigns_classes ["marks"])})

   ;; smooth scrolling
   "psliwka/vim-smoothie"

   ;; automatic window resizing
   (spec "camspiers/lens.vim" {:dependencies ["camspiers/animate.vim"]})

   (spec "t9md/vim-choosewin" {:init #(set vim.g.choosewin_overlay_enable 1)})

   "TaDaa/vimade"

   (spec "vim-airline/vim-airline" {:config #(do
                                               (set vim.g.airline#extensions#tabline#formatter "unique_tail_improved")

                                               (set vim.g.airline_powerline_fonts  1)
                                               (set vim.g.airline_highlighting_cache  1)
                                               (set vim.g.airline_exclude_preview  1)
                                               (set vim.g.airline_skip_empty_sections  1)

                                               (set vim.g.airline_mode_map {
                                                                            "__"   "-"
                                                                            :c     "C"
                                                                            :i     "I"
                                                                            :ic    "I"
                                                                            :ix    "I"
                                                                            :n     "N"
                                                                            :multi "M"
                                                                            :ni    "N"
                                                                            :no    "N"
                                                                            :R     "R"
                                                                            :Rv    "R"
                                                                            :s     "S"
                                                                            :S     "S"
                                                                            ""   "S"
                                                                            :t     "T"
                                                                            :v     "V"
                                                                            :V     "V"
                                                                            ""   "V"
                                                                            }))})

   (spec "vim-airline/vim-airline-themes" {:config #(do
                                                      (set vim.g.airline_theme "minimalist")
                                                      (set vim.g.airline_minimalist_showmod 1))})
  ])

(def- themes
  [
   ;; set the default colorscheme
   (spec "ntk148v/vim-horizon" {:lazy false
                                :config #(vim.cmd "colorscheme horizon")})
   (spec "tomasr/molokai" {:lazy true})
   (spec "vim-scripts/fruity.vim" {:lazy true})
   (spec "altercation/vim-colors-solarized" {:lazy true})
   (spec "atelierbram/Base2Tone-vim" {:lazy true})
   (spec "yuttie/hydrangea-vim" {:lazy true})
   (spec "cseelus/vim-colors-lucid" {:lazy true})
   (spec "cseelus/vim-colors-tone" {:lazy true})
   (spec "flrnprz/candid.vim" {:lazy true})
   (spec "colepeters/spacemacs-theme.vim" {:lazy true})
   (spec "phanviet/vim-monokai-pro" {:lazy true})
   (spec "cideM/yui" {:lazy true})
   (spec "bruth/vim-newsprint-theme" {:lazy true})
   (spec "arzg/vim-colors-xcode" {:lazy true})
   (spec "vim-scripts/AfterColors.vim" {:lazy true})

   (spec "rakr/vim-two-firewatch" {:lazy true
                                   :init #(set vim.g.two_firewatch_italics true)})

   (spec "ryanoasis/vim-devicons" {:init #(set vim.g.airline_powerline_fonts 1)})

   ;; Toolkit for developing new color schemes
   (spec "lifepillar/vim-colortemplate" {:lazy true})
  ])

(defn init []
  (let [plugins [
                 general-purpose-plugins
                 coding-plugins
                 language-plugins
                 text-manipulation-plugins
                 application-plugins
                 version-control-plugins
                 search-plugins
                 ui-plugins
                 themes
                ]]
    (lazy.setup plugins)))
