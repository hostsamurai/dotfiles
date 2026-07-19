(import-macros {: module} :nfnl.macros.aniseed)

(module :plugins.util)

(local {: merge} (require :nfnl.core))
(local {: spec} (require :utils.spec))
(local {: wk-spec} (require :utils.wk-spec))
(local utils (require :utils.helpers))
(local sc-im (utils.safe-require :sc-im))
(local img-clip (utils.safe-require :img-clip))

[
 ;;; LazyVim overrides 
 

 ;;; Additional plugins
 ;;; ----------------------------------------------
 
 (spec "NeogitOrg/neogit" {
                           :dependencies [
                                          "m00qek/baleia.nvim"
                                          "sindrets/diffview.nvim"
                                          "folke/snacks.nvim"
                                          ]
                           :lazy true
                           :cmd "Neogit"
                           :keys [(wk-spec "<leader>gn" "<cmd>Neogit<cr>" {:desc "Show Neogit UI"})]
                           })

  (spec "samoshkin/vim-mergetool" {:init #(do
                                            (set vim.g.mergetool_layout "LmR")
                                            (set vim.g.mergetool_prefer_revision "local"))
                                   :keys [(wk-spec "<leader>gm" "<cmd>MergetoolToggle<cr>" {:desc "Mergetool"})]})

  ;; Worktree support
  (spec "afonsofrancof/worktrees.nvim" 
        {
         :event "VeryLazy" 
         :opts {:base_path (if utils.is-claude-installed? 
                               "../claude" 
                               ".")}
         :keys [
                (wk-spec "<leader>gwc" "<cmd>WorktreeCreate<cr>" {:desc "Create a worktree"})
                (wk-spec "<leader>gwd" "<cmd>WorktreeCreate<cr>" {:desc "Delete a worktree"})
                (wk-spec "<leader>gws" "<cmd>WorktreeCreate<cr>" {:desc "Switch a worktree"})
                ]
         })

 (spec "Apeiros-46B/qalc.nvim" {:keys [["<leader>c" "<cmd>Qalc<cr>" {:desc "Calculator"}]]})

 (spec "DAmesberger/sc-im.nvim" {:keys [
                                        (wk-spec "<leader>zc" #(sc-im.close) {:desc "Close"})
                                        (wk-spec "<leader>zo" #(sc-im.open_in_scim) {:desc "Open in sc-im"})
                                        (wk-spec "<leader>zu" #(sc-im.update true) {:desc "Recalculate Table"})
                                        ]})

 ;; Paste images from system clipboard
 (spec "HakonHarnes/img-clip.nvim" 
       {
        :event "VeryLazy" 
        :opts {:default {
                         :embed_image_as_base64 false
                         :prompt_for_file_name false 
                         :drag_and_drop {:insert_mode true}
                         }}
        :keys [(wk-spec "<leader>CP" #(img-clip.open_picker) {:desc "Open Ignoring cword"})
               (wk-spec "<leader>Cp" #(img-clip.open_picker) {:desc "Open Picker for cword"})]
        })

 ;; Replace session management with mini.sessions
 (spec "nvim-mini/mini.sessions" 
       {:enabled false :keys [(merge ["<leader>qs" #(let [mini-sessions (require :mini.sessions)]
                                                      (mini-sessions.select))] {:desc "Select a session"})
                              (merge ["<leader>qS" #(let [mini-sessions (require :mini.sessions)]
                                                      (mini-sessions.write {:force true}))] {:desc "Save Current Session"})
                              (merge ["<leader>qr" #(let [mini-sessions (require :mini.sessions)
                                                          snacks (require :snacks)]
                                                      (snacks.input {:prompt "Provide a name for the session:"} (fn [name]
                                                                                                                  (mini-sessions.write name {:force true}))))] {:desc "Save session"})]})
 ]
