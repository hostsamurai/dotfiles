(module makyo-fnl.plugins.lazy.plugins.ui
  {require {{: trimr} aniseed.string
            {: spec} makyo-fnl.plugins.lazy.spec}})

(def ui-plugins
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
