(import-macros {: module} :nfnl.macros.aniseed)

(module :plugins.lang)

(local {: spec} (require :utils.spec))
(local {: wk-spec} (require :utils.wk-spec))

[
 ;; LazyVim overrides 
 (spec "julienvincent/nvim-paredit" {:opts {:indent {:enabled true}}})

 (spec "Olical/conjure" {:keys [
                                (wk-spec "<leader>mlb" 
                                         #(vim.api.nvim_exec2 (.. ":normal " vim.g.maplocalleader "eb") {:output true}) 
                                         {:desc "Eval Buffer"})
                                (wk-spec "<leader>mlee" 
                                         #(vim.api.nvim_exec2 (.. ":normal " vim.g.maplocalleader  "ee") {:output false})
                                         {:desc "Eval Inner Form"})
                                (wk-spec "<leader>mler" 
                                         #(vim.api.nvim_exec2 (.. ":normal " vim.g.maplocalleader  "er") {:output false})
                                         {:desc "Eval Outer Form"})
                                (wk-spec "<leader>mle!" 
                                         #(vim.api.nvim_exec2 (.. ":normal " vim.g.maplocalleader  "e!") {:output false})
                                         {:desc "Replace With Result"})
                                (wk-spec "<leader>mllq" 
                                         #(vim.api.nvim_exec2 (.. ":normal " vim.g.maplocalleader  "lq") {:output false})
                                         {:desc "Close Log"})
                                (wk-spec "<leader>mlls" 
                                         #(vim.api.nvim_exec2 (.. ":normal " vim.g.maplocalleader  "ls") {:output false})
                                         {:desc "Open Log in Split"})
                                (wk-spec "<leader>mllv" 
                                         #(vim.api.nvim_exec2 (.. ":normal " vim.g.maplocalleader  "lv") {:output false})
                                         {:desc "Open Log in Vertical Split"})
                                ]})

 ;;; Additional plugins
 ;;; ----------------------------------------------
 
 "yasuhiroki/github-actions-yaml.vim"
 ]
