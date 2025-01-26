(module makyo-fnl.plugins.lazy
  {require {a aniseed.core
            nvim aniseed.nvim
            {: trimr} aniseed.string}
   autoload {: lazy
             {: normal-mode-layers
              : visual-mode-layers} makyo-fnl.plugins.which-key
             octo makyo-fnl.plugins.octo
             utils makyo-fnl.utils}})

(defn- spec [plugin-name spec-definitions]
  "Gets around Fennel's limitation of being unable to mix associative
  and sequential tables by using a sequential table with the plugin
  name as its first element, followed by the rest of the plugin
  definition. This is necessary for Lazy to detect spec definitions
  correctly."
  (a.merge [plugin-name] spec-definitions))

(def- general-purpose-plugins
  [
   (spec "folke/which-key.nvim"
         {:event "VeryLazy"
          :opts {
                 :spec (a.merge normal-mode-layers visual-mode-layers)
                 :triggers {1 "<leader>" :mode ["n" "v"]}
                 :plugins {:presets {
                                     :operators false
                                     :motions false
                                     :nav false
                                     :z false
                                     :g false
                                     }}
                 }
          :dependencies "nvim-tree/nvim-web-devicons"
          })

   "skywind3000/asynctasks.vim"
   ])

(def- coding-plugins
  [
   (spec "neoclide/coc.nvim" {:branch  "release"
                              :init #(when (utils.is-darwin?)
                                       (set nvim.g.coc_node_path "~/.proto/bin/node")
                                       (set nvim.g.coc_snippet_next "<C-j>")
                                       (set nvim.g.coc_snippet_prev "<C-k>"))})

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
                                 :config true})

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
         {:init (fn []
                    (do
                      (set vim.g.javascript_plugin_jsdoc 1)
                      (set vim.g.jscomplete_use ["dom" "moz" "es6th"])
                      (set vim.g.clojure_align_multiline_strings 0)))})

   (spec "tpope/vim-fireplace" {:ft "clojure"})
   (spec "dgrnbrg/vim-redl" {:ft "clojure"})
   (spec "clojure-vim/acid.nvim" {:ft "clojure"})
   (spec "venantius/vim-eastwood" {:ft "clojure"})
   (spec "venantius/vim-cljfmt" {:ft "clojure"})

   "bakpakin/fennel.vim"
   (spec "Olical/nvim-local-fennel" {:enabled false})
   "Olical/aniseed"
   (spec "Olical/conjure"
         {:ft  ["clojure" "scheme" "racket" "chicken" "fennel"]
          :init (fn []
                  (set vim.g.conjure#client#fennel#aniseed#aniseed_module_prefix "aniseed."))})

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
   "tjdevries/nlua.nvim"
   (spec "nvim-lua/completion-nvim" {:ft "lua"})
   ;; Path context manager unit testing and luarocks installation functions
   "nvim-lua/plenary.nvim"
   (spec "euclidianAce/BetterLua.vim" {:ft "lua"})
   (spec "tjdevries/manillua.nvim" {:ft "lua"})
   (spec "bfredl/nvim-luadev" {:ft "lua"})
   "svermeulen/vimpeccable"

   (spec "teal-language/vim-teal" {:disable true})

   "vim-pandoc/vim-pandoc"

   ;; Markdown
   (spec "iamcco/markdown-preview.nvim" {:ft ["markdown" "pandoc.markdown" "rmd"]
                                         :build "cd app && yarn install"})
   (spec "davidmh/mdx.nvim" {:dependencies "nvim-treesitter/nvim-treesitter"})

   ;; An interactive scratchpad
   "metakirby5/codi.vim"
  ])

(def- application-plugins
  [
   "Apeiros-46B/qalc.nvim"
   "simnalamburt/vim-mundo"
   "acustodioo/vim-tmux"
   "DAmesberger/sc-im.nvim"

   (spec "voldikss/vim-floaterm" {:init #(set vim.g.floaterm_rootmarkers [".git" ".gitignore"])})

   (spec "lbrayner/vim-rzip" {:lazy true})

   ;; Neorg support
   (spec "nvim-neorg/neorg" {:lazy false
                             :version "*"
                             :config true})
   (spec "lukas-reineke/headlines.nvim" {:dependencies "nvim-treesitter/nvim-treesitter"
                                         :opts {:norg {:headline_highlights [
                                                                             "Headline1"
                                                                             "Headline2"
                                                                             "Headline3"
                                                                             "Headline4"
                                                                             "Headline5"
                                                                             ]
                                                       :codeblock_highlight ["NeorgCodeBlock"]}}})
   ])

(def- version-control-plugins
  [
   ;; Show a sign in the gutter to signify changes
   (spec "mhinz/vim-signify" {:init #(do
                                       (set vim.g.signify_realtime 1)
                                       (set vim.g.signify_vcs_list ["git" "hg"]))
                              :disable true})

   ;; Perform various git functions
   (spec "NeogitOrg/neogit" {:dependencies ["nvim-lua/plenary.nvim"
                                            "sindrets/diffview.nvim"
                                            "ibhagwan/fzf-lua"
                                            ]
                             :config {:integrations {"fzf_lua" true}}})

   (spec "pwntester/octo.nvim" {:dependencies ["nvim-lua/plenary.nvim"
                                               "ibhagwan/fzf-lua"
                                               "nvim-tree/nvim-web-devicons"
                                               ]
                                :config {:ui {"use_signcolumn" true}
                                         :picker "fzf-lua"
                                         :mappings {:issue (a.merge octo.issue-mappings octo.reaction-mappings)
                                                    :pull_request octo.pull-request-mappings
                                                    :review_thread octo.review-thread-mappings
                                                    :submit_win octo.submit-win-mappings
                                                    :review_diff octo.review-diff-mappings
                                                    :file_panel octo.file-panel-mappings}}})

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
                                                                       {:P  "~/dotfiles/vim/.vim/fnl/makyo-fnl/which-key/layers.fnl"}
                                                                       {:V  "~/dotfiles/vim/.vim/fnl/init.fnl"}
                                                                       {:Z  "~/dotfiles/zsh/.zshrc"}
                                                                       "~/Code"])
                                        (set vim.g.startify_session_persistence 1)
                                        (set vim.g.startify_change_to_vcs_root 0 )
                                        (set vim.g.startify_session_sort 1)
                                        (set vim.g.startify_enable_special 0))})

   "junegunn/fzf"
   (spec "junegunn/fzf.vim" {:init #(set vim.g.fzf_command_prefix "Fzf")})

   (spec "jlanzarotta/bufexplorer" {:init #(set vim.g.bufExplorerDisableDefaultKeyMapping 1)})

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

   (spec "vim-airline/vim-airline" {:init #(do
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

   (spec "vim-airline/vim-airline-themes" {:init #(do
                                                    (set vim.g.airline_theme "minimalist")
                                                    (set vim.g.airline_minimalist_showmod 1))})

   (spec "nvim-tree/nvim-web-devicons")
  ])

(def- themes
  [
   (spec "ntk148v/vim-horizon" {:lazy true
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
  ;; treesitter-compatible color schemes
   (spec "nvimdev/zephyr-nvim" {:lazy true})
   (spec "Iron-E/nvim-highlite" {:lazy true})
   ;; TODO: set this as the default theme
   (spec "rockerBOO/boo-colorscheme-nvim" {:lazy true
                                           :priority 1000
                                           :opts {:italic true :theme "crimson_moonlight"}
                                           :main "boo-colorscheme"})
   (spec "nvimdev/zephyr-nvim" {:lazy true})
   (spec "savq/melange-nvim" {:lazy true})
   (spec "matsuuu/pinkmare" {:lazy true})
   (spec "Mofiqul/dracula.nvim" {:lazy true})
   (spec "NTBBloodbath/doom-one.nvim" {:lazy true})
   (spec "sainnhe/sonokai" {:lazy true})
   (spec "comfysage/evergarden" {:lazy true
                                 :priority 1000
                                 :opts {:contrast_dark "medium"}})
   (spec "ray-x/starry.nvim" {:lazy false
                              :priority 1000
                              :opts {:style {:name "dracula_blood"}
                                     :italics {:comments true :keywords true}}})

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
