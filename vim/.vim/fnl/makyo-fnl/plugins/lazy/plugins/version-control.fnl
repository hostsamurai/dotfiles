(module makyo-fnl.plugins.lazy.plugins.version-control
  {require {a aniseed.core
            {: spec} makyo-fnl.plugins.lazy.spec}
   autoload {octo makyo-fnl.plugins.octo}})

(def version-control-plugins
  [
   ;; Show a sign in the gutter to signify changes
   (spec "mhinz/vim-signify" {:init #(do
                                       (set vim.g.signify_realtime 1)
                                       (set vim.g.signify_vcs_list ["git" "hg"]))
                              :disable true})

   ;; Perform various git functions
   (spec "NeogitOrg/neogit" {:dependencies ["nvim-lua/plenary.nvim"
                                            "sindrets/diffview.nvim"
                                            "ibhagwan/fzf-lua"
                                            ]
                             :config {:integrations {"fzf_lua" true}}})

   (spec "pwntester/octo.nvim" {:dependencies ["nvim-lua/plenary.nvim"
                                               "ibhagwan/fzf-lua"
                                               "nvim-tree/nvim-web-devicons"
                                               ]
                                :config {:ui {"use_signcolumn" true}
                                         :picker "fzf-lua"
                                         :mappings {:issue (a.merge octo.issue-mappings octo.reaction-mappings)
                                                    :pull_request octo.pull-request-mappings
                                                    :review_thread octo.review-thread-mappings
                                                    :submit_win octo.submit-win-mappings
                                                    :review_diff octo.review-diff-mappings
                                                    :file_panel octo.file-panel-mappings}}})

   ;; Open commit messages in a popup window
   (spec "rhysd/git-messenger.vim" {:cmd  "GitMessenger"})

   (spec "samoshkin/vim-mergetool" {:init #(do
                                             (set vim.g.mergetool_layout "LmR")
                                             (set vim.g.mergetool_prefer_revision "local"))})

   "f-person/git-blame.nvim"
   (spec "APZelos/blamer.nvim" {:init #(do
                                         (set vim.g.blamer_show_in_insert_modes 0)
                                         (set vim.g.blamer_show_in_visual_modes  0)
                                         (set vim.g.blamer_relative_time  1))})

   (spec "ruifm/gitlinker.nvim" {:dependencies ["nvim-lua/plenary.nvim"]
                                 :lazy true
                                 :config #(autoload {{: init} gitlinker}
                                                    (init {:mappings nil}))})

   "tyru/open-browser.vim"

   (spec "tyru/open-browser-github.vim" {:dependencies ["tyru/open-browser.vim"]
                                         :init #(set vim.g.openbrowser_github_always_d_branch 1)})
  ])
