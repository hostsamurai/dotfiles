(import-macros {: module
                : def}
                :nfnl.macros.aniseed)

(module makyo-fnl.plugins.which-key.layers.normal.fzf)

(local utils (require :makyo-fnl.plugins.which-key.utils))

(def fzf-layer
  {
   :F {
       :name "+FZF"
       :b {
            :name "+buffers"
            :b ["<cmd>FzfLua buffers<cr>" "buffers"]
            :B ["<cmd>FzfLua buffers resume=true<cr>" "resume last query"]
            }
       :f {
            :name "+files"
            :f ["<cmd>FzfLua files<cr>" "files"]
            :F ["<cmd>FzfLua files resume=true<cr>" "resume last query"]
            }
       :c ["<cmd>FzfLua colorschemes<cr>"   "color schemes"]
       :g {
            :name "+git"
            :c {
                 :name "+commits"
                 :b ["<cmd>FzfLua git_bcommits<cr>" "commits (buffer)"]
                 :B ["<cmd>FzfLua git_bcommits resume=true<cr>" "commits (buffer)"]
                 :c ["<cmd>FzfLua git_commits<cr>" "commits (project)"]
                 :C ["<cmd>FzfLua git_commits resume=true<cr>" "last commits query"]
                 }
            :d ["<cmd>FzfLua git_diff<cr>" "diff"]
            :D ["<cmd>FzfLua git_diff resume=true<cr>" "resume last diff"]
            :f ["<cmd>FzfLua git_files<cr>" "files in source control"]
            :F ["<cmd>FzfLua git_files resume=true<cr>" "reopen last viewed files query"]
            :w ["<cmd>FzfLua git_worktrees<cr>" "worktrees"]
           }
       :h {
           :name "+history"
           :c ["<cmd>FzfLua commands<cr>" "commands"]
           :C ["<cmd>FzfLua commands resume=true<cr>" "last viewed commands"]
           :h ["<cmd>FzfLua oldfiles<cr>" "mru"]
           :s ["<cmd>FzfLua history<cr>" "search history"]
           :S ["<cmd>FzfLua history resume=true<cr>" "resume search history"]
           }
       :m ["<cmd>FzfLua marks<cr>" "marks"]
       :s {
            :name "+search"
            :b ["<cmd>FzfLua blines<cr>" "buffer lines"]
            :B ["<cmd>FzfLua blines resume=true<cr>" "resume buffer lines query"]
            :c ["<cmd>FzfLua grep_cword<cr>" "word under cursor"]
            :C ["<cmd>FzfLua grep_cWORD<cr>" "WORD under cursor"]
            :g ["<cmd>FzfLua live_grep_blob<cr>" "blob"]
            :l ["<cmd>FzfLua lines<cr>" "lines"]
            :L ["<cmd>FzfLua lines resume=true<cr>" "resume lines query"]
            :r ["<cmd>FzfLua live_grep<cr>" "grep"]
            :R ["<cmd>FzfLua live_grep_resume<cr>" "resume last grep"]
            :t ["<cmd>FzfLua tags_grep<cr>" "tags"]
            :v ["<cmd>FzfLua lgrep_curbuf<cr>" "current buffer"]
            }
       :w ["<cmd>FzfWindows<cr>"    "windows"]
       }
    })
