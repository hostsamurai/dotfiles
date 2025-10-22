(module makyo-fnl.plugins.which-key.layers.normal.project)

(def project-layer
  {
   :p {
       :name "+project"
       :c {
           :name "+checks"
           :t {
               :name "+tests"
               :n ["<cmd>TestNearest<cr>" "nearest"]
               :f ["<cmd>TestFile<cr>"    "file"]
               :s ["<cmd>TestSuite<cr>"   "suite"]
               :v ["<cmd>TestVisit<cr>"   "jump to test file"]
               }
           }
       :t {
           :name "+tags"
           :c ["<cmd>GenCtags<cr>" "generate ctags"]
           :g ["<cmd>GenGTAGS<cr>" "generate gtags"]
           :v {
               :name "+view"
               :c ["<cmd>Vista coc<cr>"     "coc"]
               :C ["<cmd>Vista ctags<cr>"   "ctags"]
               :f ["<cmd>Vista focus<cr>"   "focus"]
               :F ["<cmd>Vista vim_lsp<cr>" "lsp"]
               :t ["<cmd>Vista!!<cr>"       "toggle"]
               }
           }
       }
   })
