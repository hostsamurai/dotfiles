(import-macros {: module
                : def}
                :nfnl.macros.aniseed)

(module makyo-fnl.plugins.which-key.layers.normal.fzf)

(local nvim (require :nvim))
(local utils (require :makyo-fnl.plugins.which-key.utils))

(def fzf-layer
  {
   :F {
       :name "+FZF"
       :b [#(nvim.exec "FzfBuffers" true)  "buffers"]
       :B ["<cmd>FzfBCommits<cr>" "git buffer commits"]
       :c ["<cmd>FzfColors<cr>"   "color schemes"]
       :f ["<cmd>FzfFiles<cr>"    "files"]
       :g ["<cmd>FzfGFiles<cr>"   "files in vcs"]
       :G ["<cmd>FzfGFiles?<cr>"  "git status files"]
       :h {
           :name "+history"
           :C ["<cmd>FzfHistory:<cr>" "command history"]
           :h ["<cmd>FzfHistory<cr>"  "mru"]
           :s ["<cmd>FzfHistory/<cr>" "search history"]
           }
       :l [#(utils.prompt-and-run "Search term:" ":FzfLines")  "search lines"]
       :L [#(utils.prompt-and-run "Search term:" ":FzfBLines") "search lines in buffers"]
       :m ["<cmd>FzfMarks<cr>" "marks"]
       :r [#(utils.prompt-and-run "Search term:" ":FzfRg ") "rg search"]
       :R [#(utils.prompt-and-run "Search term:" ":FzfRG ") "rg expanded search"] ;; hidden files included
       :t [#(utils.prompt-and-run "Tag:" ":FzfTags ")   "tags"]
       :T [#(utils.prompt-and-run "Tag:" ":FzfBTags ")  "buffer tags"]
       :w ["<cmd>FzfWindows<cr>"    "windows"]
       }
   })
