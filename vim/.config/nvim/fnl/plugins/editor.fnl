(import-macros {
                : module
                : def
                : defn-
                }
                :nfnl.macros.aniseed)

(module :plugins.editor)

(local {: spec} (require :utils.spec))
(local {: wk-spec} (require :utils.wk-spec))
(local {
        : safe-require
        : is-lisp-buffer?
        : is-markdown-buffer?
        } (require :utils.helpers))


[
 ;; LazyVim overrides 
 
 ;; Disable flash.nvim and replace it with hop.nvim
 (spec "folke/flash.nvim" {:enabled false})
 
 (spec "folke/which-key.nvim"
       {
        :event "VeryLazy"
        :opts {:spec [
                      (wk-spec "<leader>bs" {:group "Scratch" :icon "󱞁"})
                      (wk-spec "<leader>cY" {:group "Snippets" :icon ""})
                      (wk-spec "<leader>C" {:group "Color" :icon ""})
                      (wk-spec "<leader>M" {:group "Motion" :icon "󱖒"})
                      (wk-spec "<leader>cD" {:group "Dev Container" :icon ""})
                      (wk-spec "<leader>F" {:group "Format" :icon "󰊄"})
                      (wk-spec "<leader>gw" {:group "Worktrees" :icon ""})
                      (wk-spec "<leader>j" {:group "Jujutsu" :icon ""})
                      (wk-spec "<leader>m" 
                               {
                                :group "Mode" 
                                :icon #(if (is-lisp-buffer?)
                                           ""
                                           (is-markdown-buffer?)
                                           ""
                                           nil)
                                })
                      (wk-spec "<leader>mm" {:group "Markdown" :icon ""})
                      (wk-spec "<leader>mmt" {:group "Tables" :icon ""})
                      (wk-spec "<leader>ml" {:group "LISP" :icon ""})
                      (wk-spec "<leader>mle" {:group "Eval"})
                      (wk-spec "<leader>mll" {:group "Log"})
                      (wk-spec "<leader>T" {:group "Terminal" :icon ""})
                      (wk-spec "<leader>z" {:group "Spreadsheet" :icon "󰧷"})
                      ]}
        :keys [(wk-spec "<leader>bsm" #(let [snacks (safe-require :snacks)]
                                         (snacks.scratch {:ft "markdown"})) {:desc "Open Markdown scratch buffer"})
               (wk-spec "<leader>b<Tab>" "<cmd>b#<cr>" {:desc "Switch to Previous Buffer"})]
        })

 ;;; Additional plugins
 ;;; ----------------------------------------------
 
 ;; Replace flash.nvim for 2-letter jumping around
 (spec "yuki-yano/hop.nvim" {:keys [(wk-spec "<leader>h" #(let [hop (require :hop)]
                                                            (hop.jump_words)) {:desc "Hop words"})]})

 (spec "LZDQ/nvim-autocenter" {:event "InsertEnter"
                               :keys [(wk-spec "<leader>Fc" #(let [autocenter (require :nvim-autocenter)]
                                                               (autocenter.toggle)) {:desc "Toggle Autocenter"})]})

 (spec "christoomey/vim-tmux-navigator"
       {:lazy false :init #(set vim.g.tmux_navigator_no_mappings 1)})
 ]
