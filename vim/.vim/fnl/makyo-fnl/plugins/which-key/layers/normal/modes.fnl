(module makyo-fnl.plugins.which-key.layers.normal.modes
  {require {nvim aniseed.nvim}})

(def modes-layer
  {
   :m {
       :name "+modes"
       :a {
           :name "+ai"
           :c {
               :name "+claude"
               :c ["<cmd>tabnew ~./claude/settings.json<cr>" "open settings"]
               :p ["<cmd>ClaudeCodeResume<cr>"  "conversation picker"]
               :t ["<cmd>ClaudeCode<cr>" "toggle window"]
               :r ["<cmd>ClaudeCodeResume<cr>" "resume most recent conversation"]
               :v ["<cmd>ClaudeCodeVerbose<cr>" "verbose logging"]
               :s {
                   :name "+settings"
                   :c ["<cmd>tabnew ~./claude/settings.json<cr>" "open settings in new tab"]
                   :C ["<cmd>e ~./claude/settings.json<cr>" "open settings in current window"]
                   :m ["<cmd>tabnew .mcp.json<cr>" "open project MCP config in new tab"]
                   :M ["<cmd>e .mcp.json<cr>" "open project MCP settings in current window"]
                   }
               }
           }
       :l {
           :name "+lisp"
           :b [#(nvim.ex.execute "':normal ' . g:maplocalleader . 'eb'") "eval buffer"]
           :e {
               :name "+eval"
               :e  [#(nvim.ex.execute "':normal ' . g:maplocalleader . 'ee'") "inner form"]
               :r  [#(nvim.ex.execute "':normal ' . g:maplocalleader . 'er'") "outer form"]
               "!" [#(nvim.ex.execute "':normal ' . g:maplocalleader . 'e!'") "replace with result"]
               }
           :l {
               :name "+log-buffer"
               :c [#(nvim.ex.execute "':normal ' . g:maplocalleader . 'lq'") "close"]
               :s [#(nvim.ex.execute "':normal ' . g:maplocalleader . 'ls'") "open horizontally"]
               :v [#(nvim.ex.execute "':normal ' . g:maplocalleader . 'lv'") "open vertically"]
               }
           :p {
               :name "+paredit"
               :e [(set nvim.g.paredit_mode 1) "enable paredit"]
               :d [(set nvim.g.paredit_mode 0) "disable paredit"]
               }
           }
       :m {
           :name "+markdown"
           :p ["<cmd>MarkdownPreview<cr>" "preview"]
           }
       :n {
           :name "+nodejs"
           :r ["<cmd>FloatermNew node<cr>" "repl"]
           }
       }
   })
