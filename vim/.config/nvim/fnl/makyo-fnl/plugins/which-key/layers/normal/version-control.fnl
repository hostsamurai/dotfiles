(import-macros {: module
                : def}
               :nfnl.macros.aniseed)

(module makyo-fnl.plugins.which-key.layers.normal.version-control)

(local nvim (require :nvim))
(local utils (require :makyo-fnl.plugins.which-key.utils))

(def version-control-layer
  {
   :g {
       :name "+version-control"
       :B {
           :name "+blame"
           :i ["<cmd>BlamerToggle<cr>"        "blame inline (blame.nvim)"]
           :f ["<cmd>GitBlameOpenFileURL<cr>" "open file URL in browser"]
           :t ["<cmd>GitBlameToggle<cr>"      "blame inline"]
           }
       :d {
           :name "+diff"
           :h ["<cmd>SignifyToggleHighlight<cr>" "toggle hightlight"]
           :i ["<cmd>SignifyHunkDiff<cr>"        "inline diff"]
           }
       :h {
           :name "+hunks"
           :n ["<Plug>(signify-next-hunk)" "next"]
           :p ["<Plug>(signify-prev-hunk)" "prev"]
           :u ["<cmd>SignifyHunkUndo<cr>"          "undo changes"]
           }
       :l {
           :name "+logs"
           :c ["<Plug>(git-messenger)"            "last commit message"]
           :p ["<Plug>(git-messenger-into-popup)" "open popup"]
           }
       :m ["<cmd>MergetoolToggle<cr>" "mergetool"]
       :n {
           :name "+Neogit"
           :c ["<cmd>Neogit commit<cr>"      "open commit popup"]
           :o ["<cmd>Neogit<cr>"             "open in tab"]
           :s ["<cmd>Neogit kind=split<cr>"  "open in split"]
           :v ["<cmd>Neogit kind=vsplit<cr>" "open in vsplit"]
           }
       :o {
           :name "+octo"
           :i {
               :name "+issues"
               :L [#(utils.prompt-and-run "Issue filter(s): " ":Octo issue list ") "list issues by filter"]
               :b ["<cmd>Octo issue browser<cr>" "open in browser"]
               :c ["<cmd>Octo issue close<cr>"   "close issue"]
               :e ["<cmd>Octo issue edit<cr>"    "edit issue"]
               :O ["<cmd>Octo issue reopen<cr>"  "reopen issue"]
               :l ["<cmd>Octo issue list<cr>"    "list all issues"]
               :s ["<cmd>Octo issue search<cr>"  "live issue search"]
               :r ["<cmd>Octo issue reload<cr>"  "reload issue"]
               :u ["<cmd>Octo issue url<cr>"     "copy URL"]
               }
           :p {
                :name "+pull requests"
                :e [#(utils.prompt-and-run "PR #: " ":Octo pr edit ") "edit PR <number> in current repo"]
                :L [#(utils.prompt-and-run "Filters: " ":Octo pr list  ") "list all PRs satisfying given filter"]
                :m [#(utils.prompt-and-run "Merge method [commit|rebase|squash|delete]: " ":Octo merge ") "merge current PR using the specified method"]
                :o ["<cmd>Octo pr<cr>"	        "open PR for current branch"]
                :l ["<cmd>Octo pr list<cr>"	    "list all PRs"]
                :s ["<cmd>Octo pr search<cr>"   "live issue search"]
                :r ["<cmd>Octo pr reopen<cr>"   "reopen the PR"]
                :c ["<cmd>Octo pr create<cr>"   "create a new PR"]
                :C ["<cmd>Octo pr close<cr>"    "close the current PR"]
                :z ["<cmd>Octo pr checkout<cr>" "checkout PR"]
                :Z ["<cmd>Octo pr commits<cr>"  "List all PR commits"]
                :H ["<cmd>Octo pr changes<cr>"  "Show all diff hunks"]
                :h ["<cmd>Octo pr diff<cr>"     "Show PR diff"]
                :R ["<cmd>Octo pr ready<cr>"    "mark draft PR ready for review"]
                :d ["<cmd>Octo pr draft<cr>"    "send a PR back to draft"]
                :x ["<cmd>Octo pr checks<cr>"   "show all checks"]
                :E ["<cmd>Octo pr reload<cr>"   "reload PR"]
                :u ["<cmd>Octo pr browser<cr>"  "open in browser"]
                :U ["<cmd>Octo pr url<cr>"      "copy PR URL"]
                }
           :r {
               :name "+repo"
               :l ["<cmd>Octo repo list<cr>"    "list all contributed"]
               :f ["<cmd>Octo repo fork<cr>"    "fork repo"]
               :u ["<cmd>Octo repo browser<cr>" "open in browser"]
               :U ["<cmd>Octo repo url<cr>"     "copy repo URL"]
               :v [#(utils.prompt-and-run "Path {organization/name}: " ":Octo repo view ")	"open repo by path ({organization}/{name})"]
               }
           :c {
               :name "+comment"
               :a ["<cmd>Octo comment add<cr>"    "add comment"]
               :d ["<cmd>Octo comment delete<cr>" "delete comment"]
               }
           :t {
               :name "+thread"
               :r ["<cmd>Octo thread resolve<cr>"   "resolve thread"]
               :R ["<cmd>Octo thread unresolve<cr>" "unresolve thread"]
               }
           :l {
               :name "+labels"
               :a [#(utils.prompt-and-run "Label: " ":Octo label add ") "add label"]
               :c [#(utils.prompt-and-run "Label: " ":Octo label create ") "create label"]
               :d [#(utils.prompt-and-run "Label: " ":Octo label remove ") "remove label"]
               }
           :a {
               :name "+assignee"
               :a [#(utils.prompt-and-run "Assignee: " ":Octo assignee add ") "add assignee"]
               :d [#(utils.prompt-and-run "Assignee: " ":Octo assignee remove ") "remove assignee"]
               }
           :R {
               :name "+reviewer"
               :a [#(utils.prompt-and-run "Reviewer: " ":Octo reviewer add ") "add reviewer"]
               }
           :r {
               :name "+reactions"
               :+ ["<cmd>Octo reaction thumbs_up<cr>"   "add 👍 reaction"]
               :- ["<cmd>Octo reaction thumbs_down<cr>" "add 👎 reaction"]
               :e ["<cmd>Octo reaction eyes<cr>"        "add 👀 reaction"]
               :l ["<cmd>Octo reaction laugh<cr>"       "add 😄 reaction"]
               :c ["<cmd>Octo reaction confused<cr>"    "add 😕 reaction"]
               :r ["<cmd>Octo reaction rocket<cr>"      "add 🚀 reaction"]
               :h ["<cmd>Octo reaction heart<cr>"       "add ❤️ reaction"]
               :t ["<cmd>Octo reaction tada<cr>"        "add 🎉 reaction"]
               }
           :C {
               :name "+card"
               :a ["<cmd>Octo card add<cr>"    "assign issue/PR to a project new card"]
               :d ["<cmd>Octo card remove<cr>" "delete project card"]
               :m ["<cmd>Octo card move<cr>"   "move project card to different project/column"]
               }
           :Q {
               :name "+review"
               :s ["<cmd>Octo review start<cr>"    "start review"]
               :S ["<cmd>Octo review submit<cr>"   "submit review"]
               :r ["<cmd>Octo review resume<cr>"   "resume review"]
               :R ["<cmd>Octo review discard<cr>"  "discard review"]
               :c ["<cmd>Octo review comments<cr>" "view pending comments"]
               :C ["<cmd>Octo review commit<cr>"   "view commit to review"]
               :z ["<cmd>Octo review close<cr>"    "close the review window"]
               }
           :A ["<cmd>Octo actions<cr>" "list all octo actions"]
           :s ["<cmd>Octo search<cr>"  "search issues and PRs"]
           }
       :u {
           :name "+url"
           :b [#(nvim.cmd {:cmd "lua require\"gitlinker\".get_buf_range_url(\"n\", {action_callback = require\"gitlinker.actions\".open_in_browser})<CR>"} {:mods {:silent true}}) "buf range URL"]
           }
       :w {
           :name "+worktrees"
           :c ["<cmd>WorktreeCreate<cr>" "Create a worktree"]
           :d ["<cmd>WorktreeDelete<cr>" "Delete a worktree"]
           :s ["<cmd>WorktreeSwitch<cr>" "Switch to worktree"]
           }
       }
   })
