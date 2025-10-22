(module makyo-fnl.plugins.which-key.layers.normal.jump-and-folds)

(def jumps-and-folds-layer
  {
   :j {
       :name "+jumps/folds"
       :a {
           :name "+ale"
           :d ["<Plug>(ale_go_to_definition)"      "definition"]
           :r ["<Plug>(ale_find_references)"       "references"]
           :t ["<Plug>(ale_go_to_type_definition)" "type definition"]
           :R ["<cmd>ALERename<cr>"                        "rename symbol"]
           }
       :c {
           :name "+coc"
           :d ["<Plug>(coc-definition)"      "definition"]
           :D ["<Plug>(coc-declaration)"     "declaration"]
           :i ["<Plug>(coc-implementation)"  "implementation"]
           :o ["<Plug>(coc-openlink)"        "open link"]
           :r ["<Plug>(coc-references)"      "references"]
           :R ["<Plug>(coc-rename)"          "rename symbol"]
           :t ["<Plug>(coc-type-definition)" "type definition"]
           :e {
               :name "+errors/diagnostics"
               :n ["<Plug>(coc-diagnostic-next)"       "next diagnostic"]
               :N ["<Plug>(coc-diagnostic-next-error)" "next error"]
               :p ["<Plug>(coc-diagnostic-prev)"       "prev diagnostic"]
               :P ["<Plug>(coc-diagnostic-prev-error)" "prev error"]
               }
           }
       :j ["<Plug>(easymotion-s)" "easymotion"]
       :e {
           :name "+errors"
           :f ["<Plug>(ale_fix)"       "fix"]
           :n ["<Plug>(ale_next_wrap)" "next"]
           :p ["<Plug>(ale_prev_wrap)" "previous"]
           }
       :z {
           :name "+folds"
           "0" ["<cmd>set foldlevel=0<cr>" "level 0"]
           "1" ["<cmd>set foldlevel=1<cr>" "level 1"]
           "2" ["<cmd>set foldlevel=2<cr>" "level 2"]
           "3" ["<cmd>set foldlevel=3<cr>" "level 3"]
           "4" ["<cmd>set foldlevel=4<cr>" "level 4"]
           "5" ["<cmd>set foldlevel=5<cr>" "level 5"]
           "6" ["<cmd>set foldlevel=6<cr>" "level 6"]
           "7" ["<cmd>set foldlevel=7<cr>" "level 7"]
           "8" ["<cmd>set foldlevel=8<cr>" "level 8"]
           "9" ["<cmd>set foldlevel=9<cr>" "level 9"]
           }
       }
   })
