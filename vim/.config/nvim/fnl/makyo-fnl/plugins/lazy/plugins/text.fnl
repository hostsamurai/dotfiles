(import-macros {: module
                : def}
               :nfnl.macros.aniseed)

(module makyo-fnl.plugins.lazy.plugins.text)

(local {: spec} (require :makyo-fnl.plugins.lazy.spec))

(def text-manipulation-plugins
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

;; Export them
text-manipulation-plugins
