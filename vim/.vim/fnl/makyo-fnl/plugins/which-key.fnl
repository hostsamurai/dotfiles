;;;; Layer configuration

(module makyo-fnl.plugins.which-key
  {require {a aniseed.core
            nvim aniseed.nvim
            {: normal} aniseed.nvim.util}})

(defn prompt-and-run [prompt command]
    (let [user-input (nvim.fn.input prompt)]
        (nvim.fn.inputsave)
        (a.println "Value from user: " user-input)
        (nvim.exec (.. command user-input) true)
        (nvim.fn.inputrestore)))

(def normal-mode-layers
  {
   ;; Applications ------------------------
   :a {
       :name "+applications"
       ;; TODO: Replace this as it requires python2 and that is no
       ;; longer supported in Neovim.
       :c [":Calc"        "calculator"]
       :u [":MundoToggle" "undo tree"]
       :l {
           :name "+lang"
           :a {
               :name "+ale"
               :n [":ALENextWrap"     "next"]
               :p [":ALEPreviousWrap" "previous"]
               }
           :c {
               :name "+coc"
               :a ["<plug>(coc-codeaction)"  "execute action"]
               :f ["<plug>(coc-fix-current)" "auto fix"]
               :c [":CocConfig"              "open coc config"]
               :r [":CocRestart"             "restart language server"]
               :u [":CocUpdate"              "update coc"]
               }
           }
       :s {
           :name "+session"
           :d [#(prompt-and-run "Name of session to delete: " "SDelete ") "delete session"]
           :o [":SLoad"         "open"]
           :O [":SLoad!"        "open last session"]
           :s [#(prompt-and-run "Name of session to save: " "SSave ") "save new"]
           :u [":SSave!"        "save current"]
           }
       :S {
           :name "+scratchpad"
           :c [":Codi!"      "close"]
           :o [":Codi "      "open (filetype)"]
           :t [":Codi"       "toggle"]
           :u [":CodiUpdate" "update"]
           }
       :t {
           :name "+terminal"
            ;; FIXME: What we want to do here is the equivalent of
            ;; mapping the key to a command
           :c [#(prompt-and-run "Command to run: " "FloatermNew ") "run command"]
           :h [":FloatermHide"        "hide current"]
           :k [":FloatermKill"        "kill"]
           :K [#(nvim.exec "FloatermKill " true) "kill named"]
           :n [":FloatermNext"        "next instance"]
           :N [#(nvim.cmd {:cmd "FloatermNew --name="} {:output true}) "new named terminal"]
           :p [":FloatermPrev"        "previous instance"]
           :t [":FloatermNew"         "new terminal"]
           :T {
               :name "+toggles"
               :n [#(nvim.exec "FloatermToggle<space>" true) "toggle named"]
               :t [":FloatermToggle" "toggle last"]
               }
           }
       }

   ;; Buffers -----------------------------
   :b {
       :name "+buffer"
       ;; TODO: replace with fzf instead
       :b      ["<C-u>Denite buffer"  "find buffer"]
       :d      [":bd"                  "delete buffer"]
       :D      [":bd!"                 "force delete buffer"]
       :h      [#(nvim.exec "tabnew | Startify" true) "home buffer"]
       :m      [":BufExplorer"         "manage buffers"]
       :p      [":bprevious"           "previous buffer"]
       :s      [":Scratch"             "scratch buffer"]
       ;; Maps to <TAB>. See :help keycodes
       "<C-I>" [":b#"                  "previous buffer"]
       }

   ;; Comment/Compile ---------------------
   :c {
       :name "+comments/compile"
       :c ["<plug>NERDCommenterToggle"    "comment one line"]
       :s ["<plug>NERDCommenterSexy"      "comment sexily"]
       :u ["<plug>NERDCommenterUncomment" "uncomment"]
       }

   ;; Files -------------------------------
   :f {
       :name "+files"
       :c [#(nvim.command "let @+=expand('%:p')") "copy file path"]
       :f [":FzfFiles" "files"]
       :g [#(nvim.ex.normal "\\<C-g>") "display relative path"]
       :r [":FzfHistory" "mru"]
       :n {
           :name "+navigate"
           :o [":Dirvish"                         "open cwd"]
           :O [":Dirvish %"                       "open dir of current file"]
           :v [#(nvim.command "vsplit | Dirvish") "open cwd in vertical split"]
           }
       :v {
           :name "+vim"
           :i [":tabnew ~/.vim/fnl/makyo-fnl/ui.fnl"                "open UI config"]
           :k [":tabnew ~/.vim/fnl/makyo-fnl/mappings.fnl"          "open keymap config"]
           :p [":tabnew ~/.vim/fnl/makyo-fnl/plugins/setup.fnl"     "open plugin config"]
           :t [":tabnew $MYVIMRC"                                   "edit vimrc"]
           :u [":tabnew ~/.vim/fnl/makyo-fnl/ux.fnl"                "open UX config"]
           :w [":tabnew ~/.vim/fnl/makyo-fnl/plugins/which-key.fnl" "open which_key config"]
           }
       :z {
           :name "+zsh"
           :c [":tabnew ~/.zshrc" "open .zshrc"]
           }
       }

   ;; FZF ---------------------------------
   :F {
       :name "+FZF"
       :b [":FzfBuffers"  "buffers"]
       :B [":FzfBCommits" "git buffer commits"]
       :c [":FzfColors"   "color schemes"]
       :f [":FzfFiles"    "files"]
       :g [":FzfGFiles"   "files in vcs"]
       :G [":FzfGFiles?"  "git status files"]
       :h {
           :name "+history"
           :C [":FzfHistory:" "command history"]
           :h [":FzfHistory"  "mru"]
           :s [":FzfHistory/" "search history"]
           }
       :l [#(prompt-and-run "Search term:" ":FzfLines")  "search lines"]
       :L [#(prompt-and-run "Search term:" ":FzfBLines") "search lines in buffers"]
       :m [":FzfMarks" "marks"]
       :r [#(prompt-and-run "Search term:" ":FzfRg ") "rg search"]
       :R [#(prompt-and-run "Search term:" ":FzfRRG ") "rg search (hidden files included)"]
       :t [#(prompt-and-run "Tag:" ":FzfTags ")   "tags"]
       :T [#(prompt-and-run "Tag:" ":FzfBTags ")  "buffer tags"]
       :w [":FzfWindows"    "windows"]
       }

   ;; Version Control ---------------------
   :g {
       ;; TODO: Replace Gina
       :name "+version-control"
       :b {
           :name "+branch"
           :l [":Gina branch"                  "list branches"]
           :i [":Gina blame"                   "blame inline"]
           :I [":BlameToggle"                  "blame inline (blamer.nvim)"]
           :m [":Gina browse --exact :"        "open from master"]
           :r [":Gina browse --scheme=blame :" "blame in browser"]
           }
       :c {
           :name "+commit"
           :a [":Gina commit --amend"           "amend"]
           :c [":Gina commit"                   "commit"]
           :m [":Gina commit -m "               "simple commit"]
           :n [":Gina commit --amend --no-edit" "amend no-edit"]
           }
       :d {
           :name "+diff"
           :d [":Gina compare"           "2-buffer compare"]
           :h [":SignifyToggleHighlight" "toggle hightlight"]
           :i [":SignifyHunkDiff"        "inline diff"]
           :s [":Gina diff"              "unified diff"]
           }
       :h {
           :name "+hunks"
           :n ["<Plug>(signify-next-hunk)" "next"]
           :p ["<Plug>(signify-prev-hunk)" "prev"]
           :u [":SignifyHunkUndo"     "undo changes"]
           }
       :l {
           :name "+logs"
           :c ["<Plug>(git-messenger)"            "last commit message"]
           :l [":Gina log"                        "log"]
           :p ["<Plug>(git-messenger-into-popup)" "open popup"]
           }
       :m [":MergetoolToggle" "mergetool"]
       :p {
           :name "+push"
           :p [":Gina push" "push"]
           :f [":Gina push --force" "force push"]
           }
       :s [":Gina status"                              "status "]
       :S [#(nvim.fn.execute ["tabnew" "Gina status"]) "status in new tab"]
       :z {
           :name "+stash"
           :b [":Gina stash"       "stash buffer"]
           :s [":Gina stash show " "show"]
           }
       }

   ;; Insertion ---------------------------
   :i {
       :name "+insertion"
       :s {
           :name "+snippets"
           :c [":CocCommand snippets.openSnippetFiles" "open snippets file"]
           :e [":CocCommand snippets.editSnippets"     "edit snippets"]
           :l [":CocList snippets"                     "list snippets"]
           }
       }

     ;; Jumps/Folds -------------------------
     :j {
         :name "+jumps/folds"
         :a {
             :name "+ale"
             :d ["<Plug>(ale_go_to_definition)"      "definition"]
             :r ["<Plug>(ale_find_references)"       "references"]
             :t ["<Plug>(ale_go_to_type_definition)" "type definition"]
             :R [":ALERename"                        "rename symbol"]
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
             "0" [":set foldlevel=0" "level 0"]
             "1" [":set foldlevel=1" "level 1"]
             "2" [":set foldlevel=2" "level 2"]
             "3" [":set foldlevel=3" "level 3"]
             "4" [":set foldlevel=4" "level 4"]
             "5" [":set foldlevel=5" "level 5"]
             "6" [":set foldlevel=6" "level 6"]
             "7" [":set foldlevel=7" "level 7"]
             "8" [":set foldlevel=8" "level 8"]
             "9" [":set foldlevel=9" "level 9"]
             }
         }

   ;; Mode --------------------------------
   :m {
       :name "+modes"
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
           }

       :m {
           :name "+markdown"
           :p [":MarkdownPreview" "preview"]
           }
       :n {
           :name "+nodejs"
           :r [":FloatermNew node" "repl"]
           }
       }

   ;; Project -----------------------------
   :p {
       :name "+project"
       :c {
           :name "+checks"
           :t {
               :name "+tests"
               :n [":TestNearest" "nearest"]
               :f [":TestFile"    "file"]
               :s [":TestSuite"   "suite"]
               :v [":TestVisit"   "jump to test file"]
               }
           }
       :t {
           :name "+tags"
           :c [":GenCtags" "generate ctags"]
           :g [":GenGTAGS" "generate gtags"]
           :v {
               :name "+view"
               :c [":Vista coc"     "coc"]
               :C [":Vista ctags"   "ctags"]
               :f [":Vista focus"   "focus"]
               :F [":Vista vim_lsp" "lsp"]
               :t [":Vista!!"       "toggle"]
               }
           }
       }

   ;; Plugins -----------------------------
   :P {
       :name "+plugins"
       :c [":PackerCompile" "compile changes"]
       :C [":PackerClean" "clean"]
       :o [":tabnew ~/.vim/lua/makyo/plugins/setup.lua" "open config"]
       :u [":PackerUpdate" "update"]
       :w {
           :name "+which-key"
           :e [":tabnew ~/.vim/fnl/makyo-fnl/plugins/which-key.fnl" "edit mappings"]
           }
       }

   ;; Search ------------------------------
   :s {
       :name "+search"
       :c [":nohlsearch" "clear highlights"]
       :f [":Farf"       "search with Far"]
       :u [#(nvim.exec (a.str "FzfRRG " (nvim.fn.expand "<cword>")) true) "word under cursor"]
       :s {
           :name "+replace"
           :s ["Farr" "replace"]
           }
       }

   ;; Spelling ----------------------------
   :S {
       :name "+spelling"
       :e [":set spell"   "enable spell checker"]
       :f [":set nospell" "disable spell checker"]
       :n [#(normal "]s") "next misspelled word"]
       :p [#(normal "[s") "previous misspelled word"]
       }

   ;; Toggles -----------------------------
   :t {
       :name "+toogles"
       :c [":FzfColors" "cycle color schemes"]
       }

   ;; Windows -----------------------------
   :w {
       :name "+windows"
       :a    [":windo q"                "close all windows"]
       :s    [":exe 'split'"            "horizontal split"]
       :v    [":exe 'vsplit'"           "vertical split"]
       :c    [":close"                  "close current window"]
       :k    [":KillAllFloatingWindows" "kill floating windows"]
       :l    [":lopen"                  "open location list"]
       :q    [":copen"                  "open quickfix"]
       :W    ["<Plug>(choosewin)"       "jump to window"]
       "+"   [":resize +5"              "increase height"]
       "-"   [":resize -5"              "decrease height"]
       ;; Ignore the following
       "2" "which_key_ignore"
       "=" "which_key_ignore"
       "|" "which_key_ignore"
       :d  "which_key_ignore"
       :h  "which_key_ignore"
       :H  "which_key_ignore"
       :j  "which_key_ignore"
       :J  "which_key_ignore"
       :K  "which_key_ignore"
       :L  "which_key_ignore"
       :r  "which_key_ignore"
       :w  "which_key_ignore"
       }

   ;; Text --------------------------------
   :x {
       :name "+text"
       :a [":EasyAlign"     "align text"]
       :l [":LiveEasyAlign" "align text w/ live preview"]
       :t {
           :name "+table-mode"
           :f {
               :name "+formulas"
               :e [":TableEvalFormulaLine" "eval formula"]
               :f [":TableAddFormula"      "add cell formula"]
               }
           :r [":TableModeRealign" "realign"]
           :t [":TableModeToggle"  "toggle"]
           }
       }
   "<C-I>" [":b#" "previous buffer"]
   "*" "which_key_ignore"
   })

(def visual-mode-layers
    {
     :c {
         :name "+comments/compile"
         :c ["<plug>NERDCommenterToggle"    "comment one line"]
         :s ["<plug>NERDCommenterSexy"      "comment sexily"]
         :u ["<plug>NERDCommenterUncomment" "uncomment"]
         }

     :m {
         :name "+modes"
         :l {:name "+lisp"
             :e {
                 :name "+eval"
                 :E [#(nvim.ex.execute "'normal gv' . g:maplocalleader . 'E'") "eval selection"]
                 :w [#(nvim.ex.execute "'normal gv' . g:maplocalleader . 'Eiw'") "eval word"]
                 }
             }
         }
     })
