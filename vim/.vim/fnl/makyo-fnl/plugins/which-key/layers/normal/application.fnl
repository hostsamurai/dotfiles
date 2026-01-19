(module makyo-fnl.plugins.which-key.layers.normal.application
    {require {a aniseed.core
              nvim aniseed.nvim}
     autoload {utils makyo-fnl.plugins.which-key.utils}})

(def application-layer
  {
   :a {
       :name "+applications"
       :c ["<cmd>Qalc<cr>"        "calculator"]
       :u ["<cmd>MundoToggle<cr>" "undo tree"]
       :l {
           :name "+lang"
           :a {
               :name "+ale"
               :n ["<cmd>ALENextWrap<cr>"     "next"]
               :p ["<cmd>ALEPreviousWrap<cr>" "previous"]
               }
           :c {
               :name "+coc"
               :a ["<plug>(coc-codeaction)"  "execute action"]
               :c ["<cmd>CocConfig<cr>"      "open coc config"]
               :d ["<cmd>CocDisable<cr>"     "toggle coc off"]
               :e ["<cmd>CocEnable<cr>"      "toggle coc on"]
               :f ["<plug>(coc-fix-current)" "auto fix"]
               :r ["<cmd>CocRestart<cr>"     "restart language server"]
               :u ["<cmd>CocUpdate<cr>"      "update extensions"]
               :U ["<cmd>CocCommand extensions.forceUpdateAll<cr>"      "update extensions"]
               }
           :m {
               :name "+mason"
               :i [#(utils.prompt-and-run "LS to install: " ":MasonInstall ") "install language server"]
               :m ["<cmd>Mason<cr>" "show manager window"]
               :u ["<cmd>MasonUpdate<cr>" "update registries"]
               :t ["<cmd>MasonToolsUpdate<cr>" "update all tools"]
               }
           :t {
               :name "+treesitter"
               :i [#(utils.prompt-and-run "Language to install: " ":TSInstall ") "install language"]
               :u [#(utils.prompt-and-run "Language to update: " ":TSUpdate ") "update language"]
               :U ["<cmd>TSUpdate all<cr>"  "update all parsers"]
               }
           }
       :s {
           :name "+session"
           :d [#(utils.prompt-and-run "Name of session to delete: " nvim.g.makyo_sessions.delete) "delete session"]
           :o [#(nvim.g.makyo_sessions.select) "open"]
           :s [#(utils.prompt-and-run "Name of session to save: " (partial nvim.g.makyo_sessions.write)) "save new"]
           }
       :S {
           :name "+scratchpad"
           :c ["<cmd>Codi!<cr>"      "close"]
           :o ["<cmd>Codi <cr>"      "open (filetype)"]
           :t ["<cmd>Codi<cr>"       "toggle"]
           :u ["<cmd>CodiUpdate<cr>" "update"]
           }
       :t {
           :name "+terminal"
           :b [#(Snacks.terminal) "bottom-split terminal"]
           ;; FIXME: What we want to do here is the equivalent of
           ;; mapping the key to a command
           :c [#(utils.prompt-and-run "Command to run: " "FloatermNew ") "run command"]
           :h ["<cmd>FloatermHide<cr>"        "hide current"]
           :k ["<cmd>FloatermKill<cr>"        "kill"]
           :K [#(nvim.exec "FloatermKill " true) "kill named"]
           :n ["<cmd>FloatermNext<cr>"        "next instance"]
           :N [#(utils.prompt-and-run "Terminal name: " "FloatermNew --name=" ) "new named terminal"]
           :p ["<cmd>FloatermPrev<cr>"        "previous instance"]
           :t ["<cmd>FloatermNew<cr>"         "new terminal"]
           :T {
               :name "+toggles"
               :n [#(nvim.exec "FloatermToggle<space>" true) "toggle named"]
               :t ["<cmd>FloatermToggle<cr>" "toggle last"]
               }
           :R ["<cmd>FloatermUpdate --height=0.8 --width=0.8<cr>" "resize to 80%"]
           }
       :z {
           :name "+sc-im"
           :c ["<cmd>lua require('sc-im').close()<cr>" "close sc-im view"]
           :o ["<cmd>lua require('sc-im').open_in_scim()<cr>" "open table in sc-im"]
           :r ["<cmd>lua require('sc-im').update(true)<cr>" "recalculate table"]
           }
       }
   })
