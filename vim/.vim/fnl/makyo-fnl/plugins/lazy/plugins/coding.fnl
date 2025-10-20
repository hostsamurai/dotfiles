(module makyo-fnl.plugins.lazy.plugins.coding
  {require {nvim aniseed.nvim
            {: spec} makyo-fnl.plugins.lazy.spec}
   autoload {utils makyo-fnl.utils}})

(def coding-plugins
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

   ;; AI
   (spec "ravitemer/mcphub.nvim" {:dependencies "nvim-lua/plenary.nvim"
                                  :build "npm install -g mcp-hub@latest"
                                  :config #(let [mcphub (require :mcphub)]
                                             (mcphub.setup {}))})
   (spec "github/copilot.vim" {:lazy false})
   (spec "CopilotC-Nvim/CopilotChat.nvim" {:dependencies "nvim-lua/plenary.nvim"
                                           :build "make tiktoken"})
   (spec "yetone/avante.nvim" {:dependencies [
                                              "nvim-lua/plenary.nvim"
                                              "MunifTanjim/nui.nvim"
                                              ;; The below dependencies are optional
                                              "ibhagwan/fzf-lua" ;; for file_selector provider fzf
                                              "stevearc/dressing.nvim" ;; for input provider dressing
                                              "folke/snacks.nvim" ;; for input provider snacks
                                              "nvim-tree/nvim-web-devicons"
                                              "zbirenbaum/copilot.lua" ;; for providers='copilot'
                                              ;; support for image pasting
                                              (spec "HakonHarnes/img-clip.nvim" {:event "VeryLazy"
                                                                                 :opts {:default {"embed_image_as_base64" false "prompt_for_file_name" false "drag_and_drop" {"insert_mode" true}}}})
                                              (spec "MeanderingProgrammer/render-markdown.nvim" {:opts {:file_types ["markdown" "avante"]}
                                                                                                 :ft ["markdown" "avante"]})
                                              ]
                               :build "make"
                               :event "VeryLazy"})

   ])
