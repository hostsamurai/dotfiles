(import-macros {: module
                : def}
               :nfnl.macros.aniseed)

(module makyo-fnl.plugins.lazy.plugins.ui)

(local {: trimr} (require :nfnl.core))
(local {: spec} (require :makyo-fnl.plugins.lazy.spec))
(local utils (require :makyo-fnl.utils))
(local aleph (require :makyo-fnl.plugins.alpha))

(def ui-plugins
  [
   (spec "goolord/alpha-nvim" {:dependencies ["nvim-tree/nvim-web-devicons" "nvim-mini/mini.nvim"]
                               :config #(let [alpha (utils.safe-require "alpha")
                                              dashboard (utils.safe-require "alpha.themes.dashboard")
                                              custom-layout (aleph.create-config dashboard)]
                                          (alpha.setup custom-layout))})

   "junegunn/fzf"
   (spec "junegunn/fzf.vim" {:init #(do
                                      (set vim.g.fzf_command_prefix "Fzf")
                                      (set vim.g.fzf_history_dir "~/.local/share/fzf-history")
                                      (set vim.g.fzf_vim {
                                                          :window {:height "50%"}
                                                          :preview_window ["right,50%" "ctrl-/"]
                                                          ;; [Buffers] Jump to existing window if possible
                                                          :buffers_jump 1
                                                          ;; [Tags] Command to generate tags files
                                                          :tags_command "ctags -R"
                                                          })
                                      (set vim.g.fzf_action {
                                                             :ctrl-t "tab vsplit"
                                                             :ctrl-s "split"
                                                             :ctrl-v "vsplit"
                                                             }))})

   (spec "jlanzarotta/bufexplorer" {:init #(set vim.g.bufExplorerDisableDefaultKeyMapping 1)})

   (spec "nvimdev/indentmini.nvim" {:cmd ["IndentToggle" "IndentEnable" "IndentDisable"]
                                    :lazy true
                                    :config #(let [indentmini (utils.safe-require "indentmini")]
                                               (do
                                                 (indentmini.setup {:only_current false
                                                                    :enabled true
                                                                    :minlevel 4
                                                                    :char "▏"
                                                                    :exclude ["markdown" "help" "text" "terminal"]
                                                                    :exclude_nodetype ["string" "comment"]})
                                                 (indentmini.enable)))})

   (spec "tomtom/quickfixsigns_vim" {:init #(set vim.g.quickfixsigns_classes ["marks"])})

   ;; smooth scrolling
   "psliwka/vim-smoothie"

   ;; automatic window resizing
   (spec "camspiers/lens.vim" {:dependencies ["camspiers/animate.vim"]})

   (spec "s1n7ax/nvim-window-picker" {:name "window-picker"
                                      :event "VeryLazy"
                                      :version "2.*"
                                      :config #(let [window-picker (utils.safe-require "window-picker")]
                                                 (do
                                                   ;; Expose widow-picker outside of the `:lua` context
                                                   (set vim.g.windowpicker window-picker)
                                                   (window-picker.setup)))})

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

;; Export them
ui-plugins
