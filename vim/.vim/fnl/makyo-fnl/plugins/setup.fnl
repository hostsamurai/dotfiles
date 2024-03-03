(module makyo-fnl.plugins.setup
  {require {: packer
            a aniseed.core
            nvim aniseed.nvim
            {: trimr} aniseed.string}})

(defn- use [plugin opts]
  "Gets around Fennel's limitation of being unable to mix associative
  and sequential tables by associating the first index of the table to
  the name of the plugin that we're trying to use."
  (a.assoc opts 1 plugin))

(def- general-purpose-plugins
  [
   ;; Let packer manage itself as an optional plugin
   "wbthomason/packer.nvim"

   (use "liuchengxu/vim-better-default" {:opt  false
                                         :config (fn []
                                                   (do
                                                     (set vim.g.vim_better_default_key_mapping 0)
                                                     (set vim.g.vim_better_default_persistent_undo 1)))})

   (use "liuchengxu/vim-which-key" {:opt false
                                    :setup (fn []
                                             (do
                                               (set vim.g.which_key_align_by_separator 1)
                                               (set vim.g.which_key_use_floating_win  1)
                                               (set vim.g.which_key_timeout 500)))
                                    :config (fn []
                                              (vim.fn.which_key#register "<Space>" "g:which_key_map"))
                                    :rocks  "tl"})

   "skywind3000/asynctasks.vim"])

(def- coding-plugins
  [
   (use "neoclide/coc.nvim"
     {:branch  "release"})

   "jsfaint/gen_tags.vim"
   "liuchengxu/vista.vim"

   "honza/vim-snippets"
   "Shougo/context_filetype.vim"

   (use "justinmk/vim-dirvish"
        {:setup (fn []
                  (set vim.g.dirvish_mode ":sort ,^.*[\\/],"))})
   ;; Show git status flags along Dirvish
   "kristijanhusak/vim-dirvish-git"
   ;; List all files defined by your projections with the Dirvish plugin
   "fsharpasharp/vim-dirvinist"

   (use "numToStr/Comment.nvim" {:config #(let [c (require :Comment)]
                                            (c.setup))})
   (use "scrooloose/nerdcommenter"
        {:disable true
         :setup (fn []
                  (do
                    (set vim.g.NERDSpaceDelim 0)
                    (set vim.g.NERDTrimTrailingWhitespace 1)))})

   (use "dense-analysis/ale"
        {:setup (fn []
                  (do
                    (set vim.g.airline#extensions#ale#enabled 1)
                    (set vim.g.ale_disable_lsp 1)
                    (set vim.g.ale_set_balloons 1)
                    (set vim.g.ale_fix_on_save 1)
                    (set vim.g.ale_fixers {:javascript ["prettier" "eslint"]
                                           :* ["remove_trailing_lines" "trim_whitespace"]})))})

   (use "editorconfig/editorconfig-vim"
        {:setup (fn []
                  (do
                    (set vim.g.EditorConfig_exclude_patterns  ["fugitive://.*"])
                    (set vim.g.EditorConfig_core_mode "external_command")))})

   "tpope/vim-endwise"
   "tpope/vim-classpath"
   "tpope/vim-repeat"
   "amix/open_file_under_cursor.vim"
   "tpope/vim-dispatch"
   "vim-test/vim-test"
   "tpope/vim-projectionist"

   (use "rrethy/vim-hexokinase"
        {:run "make hexokinase"
         :setup (fn []
                  (do
                    (set vim.g.all_hexokinase_patterns  ["full_hex"
                                                         "triple_hex"
                                                         "rgb"
                                                         "rgba"
                                                         "hsl"
                                                         "hsla"])
                    (set vim.g.Hexokinase_ftOptInPatterns  {:css      vim.g.all_hexokinase_patterns
                                                            :less     vim.g.all_hexokinase_patterns
                                                            :scss     vim.g.all_hexokinase_patterns
                                                            :sass     vim.g.all_hexokinase_patterns
                                                            :clojure  "full_hextriple_hexhslhsla"})
                    (set vim.g.Hexokinase_ftEnabled   ["css" "less" "sass" "scss" "clojure"])
                    (set vim.g.Hexokinase_ftDisabled  ["help"])))})

   "mattn/emmet-vim"])

(def- text-manipulation-plugins
  [
   "terryma/vim-multiple-cursors"
   "t9md/vim-textmanip"
   "tpope/vim-speeddating"
   "tpope/vim-surround"
   "vim-scripts/visincr"

   (use "losingkeys/vim-niji"
        {:ft  ["lisp" "scheme" "clojure" "fennel" "janet"]
         :setup (fn []
                  (set vim.g.niji_matching_filetypes  ["lisp" "scheme" "clojure" "fennel" "janet"]))})

   (use "AndrewRadev/switch.vim"
        {:cmd "Switch"
         :setup (fn []
                  ;; TODO: Get rid of this
                  (set vim.g.switch_mapping  "<Space>tt" ))})

   "junegunn/vim-easy-align"
   "wellle/targets.vim"
   "rhysd/clever-f.vim"

   (use "dhruvasagar/vim-table-mode"
        {:opt  true
         :cmd  ["TableModeToggle" "TableModeEnable" "Tableize"]})

   (use "dkarter/bullets.vim"
        {:setup (fn []
                  (set vim.g.bullets_set_mappings 0))})])

(def- language-plugins
  [
   (use "nvim-treesitter/nvim-treesitter" {:run (fn []
                                                  (if (nvim.fn.exists ":TSUpdate")
                                                    (nvim.command "TSUpdate")
                                                    (let [ts-install (require :nvim-treesitter.install)
                                                          ts-update (ts-install.update {:with_sync true})]
                                                      (ts-update))))})

   ;; Treesitter support
   (use "nvim-treesitter/nvim-treesitter-context")
   (use "windwp/nvim-ts-autotag")

   ;; LSP support
   (use "neovim/nvim-lspconfig")
   (use "williamboman/mason.nvim")
   (use "williamboman/mason-lspconfig.nvim")
   (use "nvimdev/lspsaga.nvim" {:after "nvim-lspconfig"
                                :config #(do
                                           (let [lspsaga (require :lspsaga)]
                                             (lspsaga.setup {})))})

  ;; DSP support
  (use "mfussenegger/nvim-dap")
  (use "rcarriga/nvim-dap-ui" {:requires "mfussenegger/nvim-dap"})

  ;; Linter support
  (use "mfussenegger/nvim-lint" {:config #(let [lint (require :lint)]
                                            (set lint.linters_by_ft {:bash       ["shellcheck"]
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
                                                                     :zsh        ["shellcheck"]}))})

  ;; Formatting support
  (use "mhartington/formatter.nvim")

   ;; Ultimate syntax collection
   (use "sheerun/vim-polyglot"
        {:config (fn []
                   (do
                     (set vim.g.javascript_plugin_jsdoc 1)
                     (set vim.g.jscomplete_use ["dom" "moz" "es6th"])
                     (set vim.g.clojure_align_multiline_strings 0)))})

   (use "tpope/vim-fireplace" {:ft "clojure"})
   (use "dgrnbrg/vim-redl" {:ft "clojure"})
   (use "clojure-vim/acid.nvim" {:ft "clojure"})

   "bakpakin/fennel.vim"
   (use "Olical/nvim-local-fennel" {:disable  true})
   (use "Olical/aniseed"
        {:config (fn []
                   (set vim.g.aniseed#env true))})
   (use "Olical/conjure"
        {:ft  ["clojure" "scheme" "racket" "chicken" "fennel"]
         :setup (fn []
                  (set vim.g.conjure#client#fennel#aniseed#aniseed_module_prefix "aniseed."))})

   (use "kovisoft/paredit"
        {:ft  ["clojure" "scheme" "racket" "chicken" "fennel"]
         :setup (fn []
                  (do
                    (set vim.g.paredit_mode 1)
                    (set vim.g.paredit_shortmaps 1)
                    (set vim.g.paredit_smartjump 1)
                    (set vim.g.paredit_leader "")))})

   (use "guileen/vim-node" {:ft "javascript"})
   (use "myhere/vim-nodejs-complete" {:ft "javascript"})
   (use "prettier/vim-prettier"
        {:run "npm install --frozen-lockfile --production"
         :ft ["javascript"
              "typescript"
              "typescriptreact"
              "less"
              "css"
              "scss"
              "json"
              "graphql"
              "markdown"
              "yaml"
              "html"]})

   (use "tpope/vim-rails" {:ft  "ruby"})

   ;; Lua
   "tjdevries/nlua.nvim"
   (use "nvim-lua/completion-nvim" {:ft "lua"})
   ;; Path context manager unit testing and luarocks installation functions
   "nvim-lua/plenary.nvim"
   (use "euclidianAce/BetterLua.vim" {:ft "lua"})
   (use "tjdevries/manillua.nvim" {:ft "lua"})
   (use "bfredl/nvim-luadev" {:ft "lua"})
   "svermeulen/vimpeccable"

   "teal-language/vim-teal"

   "vim-pandoc/vim-pandoc"

   (use "iamcco/markdown-preview.nvim"
        {:ft  ["markdown" "pandoc.markdown" "rmd"]
         :run "cd app && yarn install"})

   ;; An interactive scratchpad
   "metakirby5/codi.vim"])

(def- application-plugins
  [
   "gregsexton/VimCalc"
   "simnalamburt/vim-mundo"
   "acustodioo/vim-tmux"

   (use "voldikss/vim-floaterm"
        {:setup (fn []
                  (set vim.g.floaterm_rootmarkers [".git" ".gitignore"]))})]

  (use "lbrayner/vim-rzip" {:opt true}))

(def- version-control-plugins
  [
   ;; Show a sign in the gutter to signify changes
   (use "mhinz/vim-signify"
        {:setup (fn []
                  (do
                    (set vim.g.signify_realtime 1)
                    (set vim.g.signify_vcs_list ["git" "hg"])))})

   ;; Perform various git functions
   (use "lambdalisue/gina.vim" {:cmd  "Gina" :disable true})
   (use "NeogitOrg/neogit"
        {:disable true
         :requires "nvim-lua/plenary.nvim"
         :setup (fn []
                  (do
                    (let [neogit (require :neogit)]
                      (neogit.setup {}))))})

   ;; Open commit messages in a popup window
   (use "rhysd/git-messenger.vim"
        {:cmd  "GitMessenger"})

   (use "samoshkin/vim-mergetool"
        {:setup (fn []
                  (do
                    (set vim.g.mergetool_layout "LmR")
                    (set vim.g.mergetool_prefer_revision "local")))})

   (use "f-person/git-blame.nvim")
   (use "APZelos/blamer.nvim"
        {:setup (fn []
                  (do
                    (set vim.g.blamer_show_in_insert_modes 0)
                    (set vim.g.blamer_show_in_visual_modes  0)
                    (set vim.g.blamer_relative_time  1)))})

  (use "ruifm/gitlinker.nvim"
       {:requires "nvim-lua/plenary.nvim"
        :opt true
        :config (fn []
                  (autoload {{: setup} gitlinker}
                            (setup {:mappings nil})))})

   "tyru/open-browser.vim"

   (use "tyru/open-browser-github.vim"
        {:requires "tyru/open-browser.vim"
         :setup (fn []
                  (set vim.g.openbrowser_github_always_used_branch 1))})])

(def- search-plugins
  [
   "jremmen/vim-ripgrep"
   "bronson/vim-visual-star-search"
   "Lokaltog/vim-easymotion"
   "brooth/far.vim"])

(def- ui-plugins
  [
   (use "mhinz/vim-startify"
        {:setup (fn []
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

   (use "junegunn/fzf"
        {:cond (let [env (trimr (nvim.fn.system "uname"))]
                 (= (a.str env) "Darwin"))})
   (use "junegunn/fzf.vim"
        {:setup (fn []
                  (set vim.g.fzf_command_prefix "Fzf"))})

   (use "jlanzarotta/bufexplorer"
        {:opt true
         :setup (fn []
                  (set vim.g.bufExplorerDisableDefaultKeyMapping 1))})

   (use "Yggdroot/indentLine"
        {:setup (fn []
                  (do
                    (set vim.g.indentLine_fileTypeExclude ["text" "help"])
                    (set vim.g.indentLine_bufNameExclude ["_.*" "Startify*"])
                    (set vim.g.indentLine_char "┊")))})

   (use "tomtom/quickfixsigns_vim"
        {:setup (fn []
                  (set vim.g.quickfixsigns_classes ["marks"]))})

   "psliwka/vim-smoothie"

   (use "camspiers/lens.vim" {:requires "camspiers/animate.vim"})

   (use "t9md/vim-choosewin"
        {:setup (fn []
                  (set vim.g.choosewin_overlay_enable 1))})

   "TaDaa/vimade"

   (use "vim-airline/vim-airline"
        {:config (fn []
                   (do
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
                                                  ""   "V"})))})

   (use "vim-airline/vim-airline-themes"
        {:config (fn []
                   (do
                     (set vim.g.airline_theme "minimalist")
                     (set vim.g.airline_minimalist_showmod 1)))})])

(def- themes
  [
   "tomasr/molokai"
   "vim-scripts/fruity.vim"
   "altercation/vim-colors-solarized"
   "atelierbram/Base2Tone-vim"
   "ntk148v/vim-horizon"
   "yuttie/hydrangea-vim"
   "cseelus/vim-colors-lucid"
   "cseelus/vim-colors-tone"
   "flrnprz/candid.vim"
   "colepeters/spacemacs-theme.vim"
   "phanviet/vim-monokai-pro"
   "cideM/yui"
   "bruth/vim-newsprint-theme"
   "arzg/vim-colors-xcode"
   "vim-scripts/AfterColors.vim"

   (use "rakr/vim-two-firewatch"
        {:setup (fn []
                  (set vim.g.two_firewatch_italics true))})

   (use "ryanoasis/vim-devicons"
        {:config (fn []
                   (set vim.g.airline_powerline_fonts 1))})

   ;; Toolkit for developing new color schemes
   "lifepillar/vim-colortemplate"])

(defn init []
  (let [{: use : use_rocks} packer]
    (packer.init)
    (packer.reset)

    (do
      (use_rocks "tl")
      (use_rocks "compat53")
      (use_rocks "moses"))

    (do
      (use general-purpose-plugins)
      (use language-plugins)
      (use coding-plugins)
      (use text-manipulation-plugins)
      (use application-plugins)
      (use version-control-plugins)
      (use search-plugins)
      (use ui-plugins)
      (use themes))))
