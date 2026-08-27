(import-macros {: module} :nfnl.macros.aniseed)

(module :plugins.formatting)

(local {: spec} (require :utils.spec))
(local {: wk-spec} (require :utils.wk-spec))
(local {: is-markdown-buffer?} (require :utils.helpers))

[
 ;; LazyVim overrides 
 
 (spec "stevearc/conform.nvim" 
       {:opts {:formatters {:markdownlint-cli2 {:append_args ["--fix" "$filename"]}}}})

 (spec "MeanderingProgrammer/render-markdown.nvim" 
       {:config #(let [render-markdown (require :render-markdown)]
                   (render-markdown.setup {
                                           :heading {
                                                     :render_modes true
                                                     :border true
                                                     :border_virtual true
                                                     }
                                           :lsp {:enabled true}
                                           :completions {:enabled true}
                                           :indent {:enabled true :skip_heading true}
                                           }))})


 ;;; Additional plugins
 ;;; ----------------------------------------------
 
 (spec "dhruvasagar/vim-table-mode" 
       {
        :lazy true 
        :cmd  [
               "TableModeToggle" 
               "TableModeEnable" 
               "Tableize"
               ]
        :keys [
               (wk-spec "<leader>mmta" "<cmd>TableAddFormula<cr>" 
                        {:desc "Add Formula" :cond #(is-markdown-buffer?)})
               (wk-spec "<leader>mmte" "<cmd>TableEvalFormulaLine<cr>" 
                        {:desc "Eval Formula" :cond #(is-markdown-buffer?)})
               (wk-spec "<leader>mmtr" "<cmd>TableModeToggle<cr>" 
                        {:desc "Realign Table" :cond #(is-markdown-buffer?)})
               (wk-spec "<leader>mmtt" "<cmd>TableModeToggle<cr>" 
                        {:desc "Toggle Table Mode" :cond #(is-markdown-buffer?)})
               ]
        })

 (spec "junegunn/vim-easy-align" {:enabled false 
                                  :keys [(wk-spec "<leader>FA" "<cmd>EasyAlign<cr>" 
                                                  {:desc "Align Text"})
                                         (wk-spec "<leader>Fp" "<cmd>LiveEasyAlign<cr>" 
                                                  {:desc "Align with Preview"})]})

 ;; Align text like EasyAlign 
 (spec "nvim-mini/mini.align" 
       {:opts {:mappings {:start "<leader>FA" :start_with_preview "<leader>Fp"}}})

 ;; ghostty
 (spec "landerson02/ghostty-theme-sync.nvim" {:opts {:config "~/.config/ghostty/ghostty.config"}})
 (spec "bezhermoso/tree-sitter-ghostty" {:install "make nvim_install"})
 ]
