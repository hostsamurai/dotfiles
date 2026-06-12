(import-macros {: module
                : def
                }
                :nfnl.macros.aniseed)

(module makyo-fnl.plugins.which-key.layers.normal.file)

(local nvim (require :nvim))

(def file-layer
  {
   :f {
       :name "+files"
       :c [#(nvim.command "let @+=expand('%:p')") "copy file path"]
       :f ["<cmd>FzfFiles<cr>" "files"]
       :g [#(nvim.ex.normal "\\<C-g>") "display relative path"]
       :r ["<cmd>FzfHistory<cr>" "mru"]
       :n {
           :name "+navigate"
           :o ["<cmd>Dirvish<cr>"                 "open cwd"]
           :O ["<cmd>Dirvish %<cr>"               "open dir of current file"]
           :v [#(nvim.command "vsplit | Dirvish") "open cwd in vertical split"]
           }
       :v {
           :name "+vim"
           :i ["<cmd>tabnew ~/.vim/fnl/makyo-fnl/ui.fnl<cr>"                "open UI config"]
           :k ["<cmd>tabnew ~/.vim/fnl/makyo-fnl/mappings.fnl<cr>"          "open keymap config"]
           :p ["<cmd>tabnew ~/.vim/fnl/makyo-fnl/plugins/setup.fnl<cr>"     "open plugin config"]
           :t ["<cmd>tabnew $MYVIMRC<cr>"                                   "edit vimrc"]
           :u ["<cmd>tabnew ~/.vim/fnl/makyo-fnl/ux.fnl<cr>"                "open UX config"]
           :w ["<cmd>tabnew ~/.vim/fnl/makyo-fnl/plugins/which-key.fnl<cr>" "open which_key config"]
           }
       :z {
           :name "+zsh"
           :c ["<cmd>tabnew ~/.zshrc<cr>" "open .zshrc"]
           }
       }
   })
