;;;; Layer configuration

(module makyo-fnl.plugins.which-key
        {autoload {a aniseed.core
                   nvim aniseed.nvim
                   {: normal} aniseed.nvim.util}})

(defn prompt-and-run [prompt command]
    (let [user-input (nvim.fn.input prompt)]
        (nvim.fn.inputsave)
        (a.println "Value from user: " user-input)
        (nvim.exec (.. command user-input) true)
        (nvim.fn.inputrestore)))

(def- tab (nvim.replace_termcodes "<Tab>" true true true))

(def normal-mode-layers
  {
   ;; Applications ------------------------
   :a {
       :name "+applications"
       ;; TODO: Replace this as it requires python2 and that is no
       ;; longer supported in Neovim.
       :c ["<cmd>Calc<cr>"        "calculator"]
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
               :f ["<plug>(coc-fix-current)" "auto fix"]
               :c ["<cmd>CocConfig<cr>"              "open coc config"]
               :r ["<cmd>CocRestart<cr>"             "restart language server"]
               :u ["<cmd>CocUpdate<cr>"              "update coc"]
              }
           :t {
               :name "+treesitter"
               :i [#(prompt-and-run "Language to install: " ":TSInstall ") "install language"]
               :u [#(prompt-and-run "Language to update: " ":TSUpdate ") "update language"]
               :U ["<cmd>TSUpdate all<cr>"  "update all parsers"]
             }
          }
       :s {
           :name "+session"
           :d [#(prompt-and-run "Name of session to delete: " "SDelete ") "delete session"]
           :o ["<cmd>SLoad<cr>"         "open"]
           :O ["<cmd>SLoad!<cr>"        "open last session"]
           :s [#(prompt-and-run "Name of session to save: " "SSave ") "save new"]
           :u ["<cmd>SSave!<cr>"        "save current"]
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
            ;; FIXME: What we want to do here is the equivalent of
            ;; mapping the key to a command
           :c [#(prompt-and-run "Command to run: " "FloatermNew ") "run command"]
           :h ["<cmd>FloatermHide<cr>"        "hide current"]
           :k ["<cmd>FloatermKill<cr>"        "kill"]
           :K [#(nvim.exec "FloatermKill " true) "kill named"]
           :n ["<cmd>FloatermNext<cr>"        "next instance"]
           :N [#(nvim.cmd {:cmd "FloatermNew --name="} {:output true}) "new named terminal"]
           :p ["<cmd>FloatermPrev<cr>"        "previous instance"]
           :t ["<cmd>FloatermNew<cr>"         "new terminal"]
           :T {
               :name "+toggles"
               :n [#(nvim.exec "FloatermToggle<space>" true) "toggle named"]
               :t ["<cmd>FloatermToggle<cr>" "toggle last"]
              }
          }
      }

   ;; Buffers -----------------------------
   :b {
       :name "+buffer"
       ;; TODO: replace with fzf instead
       :b      ["<cmd>FzfBuffers<cr>"  "find buffer"]
       :d      ["<cmd>bd<cr>"                  "delete buffer"]
       :D      ["<cmd>bd!<cr>"                 "force delete buffer"]
       :h      [#(nvim.exec "tabnew | Startify" true) "home buffer"]
       :m      ["<cmd>BufExplorer<cr>"         "manage buffers"]
       :p      ["<cmd>bprevious<cr>"           "previous buffer"]
       :s      ["<cmd>Scratch<cr>"             "scratch buffer"]
       ;; Maps to <TAB>. See :help keycodes
       tab ["<cmd>b#<cr>"                  "previous buffer"]
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
       :f ["<cmd>FzfFiles<cr>" "files"]
       :g [#(nvim.ex.normal "\\<C-g>") "display relative path"]
       :r ["<cmd>FzfHistory<cr>" "mru"]
       :n {
           :name "+navigate"
           :o ["<cmd>Dirvish<cr>"                         "open cwd"]
           :O ["<cmd>Dirvish %<cr>"                       "open dir of current file"]
           :v [#(nvim.command "vsplit | Dirvish") "open cwd in vertical split"]
          }
       :v {
           :name "+vim"
           :i ["<cmd>tabnew ~/.vim/fnl/makyo-fnl/ui.fnl<cr>"                "open UI config"]
           :k ["<cmd>tabnew ~/.vim/fnl/makyo-fnl/mappings.fnl<cr>"          "open keymap config"]
           :p ["<cmd>tabnew ~/.vim/fnl/makyo-fnl/plugins/setup.fnl<cr>"     "open plugin config"]
           :t ["<cmd>tabnew $MYVIMRC<cr>"                                   "edit vimrc"]
           :u ["<cmd>tabnew ~/.vim/fnl/makyo-fnl/ux.fnl<cr>"                "open UX config"]
           :w ["<cmd>tabnew ~/.vim/fnl/makyo-fnl/plugins/which-key.fnl<cr>" "open which_key config"]
          }
       :z {
           :name "+zsh"
           :c ["<cmd>tabnew ~/.zshrc<cr>" "open .zshrc"]
          }
      }

   ;; FZF ---------------------------------
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
       :l [#(prompt-and-run "Search term:" ":FzfLines")  "search lines"]
       :L [#(prompt-and-run "Search term:" ":FzfBLines") "search lines in buffers"]
       :m ["<cmd>FzfMarks<cr>" "marks"]
       :r [#(prompt-and-run "Search term:" ":FzfRg ") "rg search"]
       :R [#(prompt-and-run "Search term:" ":FzfRRG ") "rg search (hidden files included)"]
       :t [#(prompt-and-run "Tag:" ":FzfTags ")   "tags"]
       :T [#(prompt-and-run "Tag:" ":FzfBTags ")  "buffer tags"]
       :w ["<cmd>FzfWindows<cr>"    "windows"]
      }

   ;; Version Control ---------------------
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
       :u {
           :name "+url"
           :b [#(nvim.cmd {:cmd "lua require\"gitlinker\".get_buf_range_url(\"n\", {action_callback = require\"gitlinker.actions\".open_in_browser})<CR>"} {:mods {:silent true}}) "buf range URL"]
           :B [#(nvim.cmd {:cmd "lua require\"gitlinker\".get_repo_url({action_callback = require\"gitlinker.actions\".open_in_browser})<CR>"} {:output true} {:mods {:silent true}}) "open home page URL"]
           :h [#(nvim.cmd {:cmd "lua require\"gitlinker\".get_repo_url()<CR>"} {:output true} {:mods {:silent true}}) "home page URL"]
          }
      }

   ;; Insertion ---------------------------
   :i {
       :name "+insertion"
       :s {
           :name "+snippets"
           :c ["<cmd>CocCommand snippets.openSnippetFiles<cr>" "open snippets file"]
           :e ["<cmd>CocCommand snippets.editSnippets<cr>"     "edit snippets"]
           :l ["<cmd>CocList snippets<cr>"                     "list snippets"]
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
           :p ["<cmd>MarkdownPreview<cr>" "preview"]
          }
       :n {
           :name "+nodejs"
           :r ["<cmd>FloatermNew node<cr>" "repl"]
          }
      }

   ;; Project -----------------------------
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

   ;; Plugins -----------------------------
   :P {
       :name "+plugins"
       :c ["<cmd>PackerCompile<cr>" "compile changes"]
       :C ["<cmd>PackerClean<cr>" "clean"]
       :o ["<cmd>tabnew ~/.vim/lua/makyo/plugins/setup.lua<cr>" "open config"]
       :u ["<cmd>PackerUpdate<cr>" "update"]
       :w {
           :name "+which-key"
           :e ["<cmd>tabnew ~/.vim/fnl/makyo-fnl/plugins/which-key.fnl<cr>" "edit mappings"]
          }
      }

   ;; Search ------------------------------
   :s {
       :name "+search"
       :c ["<cmd>nohlsearch<cr>" "clear highlights"]
       :f ["<cmd>Farf<cr>"       "search with Far"]
       :u [#(nvim.exec (a.str "FzfRRG " (nvim.fn.expand "<cword>")) true) "word under cursor"]
       :s {
           :name "+replace"
           :s ["Farr" "replace"]
          }
      }

   ;; Spelling ----------------------------
   :S {
       :name "+spelling"
       :e ["<cmd>set spell<cr>"   "enable spell checker"]
       :f ["<cmd>set nospell<cr>" "disable spell checker"]
       :n [#(normal "]s") "next misspelled word"]
       :p [#(normal "[s") "previous misspelled word"]
      }

   ;; Toggles -----------------------------
   :t {
       :name "+toogles"
       :c ["<cmd>FzfColors<cr>" "cycle color schemes"]
      }

   ;; Windows -----------------------------
   :w {
       :name "+windows"
       :a    ["<cmd>windo q<cr>"                "close all windows"]
       :s    ["<cmd>exe 'split'<cr>"            "horizontal split"]
       :v    ["<cmd>exe 'vsplit'<cr>"           "vertical split"]
       :c    ["<cmd>close<cr>"                  "close current window"]
       :k    ["<cmd>KillAllFloatingWindows<cr>" "kill floating windows"]
       :l    ["<cmd>lopen<cr>"                  "open location list"]
       :q    ["<cmd>copen<cr>"                  "open quickfix"]
       :W    ["<Plug>(choosewin)"       "jump to window"]
       "+"   ["<cmd>resize +5<cr>"              "increase height"]
       "-"   ["<cmd>resize -5<cr>"              "decrease height"]
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
       :a ["<cmd>EasyAlign<cr>"     "align text"]
       :l ["<cmd>LiveEasyAlign<cr>" "align text w/ live preview"]
       :t {
           :name "+table-mode"
           :f {
               :name "+formulas"
               :e ["<cmd>TableEvalFormulaLine<cr>" "eval formula"]
               :f ["<cmd>TableAddFormula<cr>"      "add cell formula"]
               }
           :r ["<cmd>TableModeRealign<cr>" "realign"]
           :t ["<cmd>TableModeToggle<cr>"  "toggle"]
           }
      }
   tab ["<cmd>b#<cr>" "previous buffer"]
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

   :g {
       :name "+version-control"
       :u {
           :name "+url"
           :b [#(nvim.cmd {:cmd "lua require\"gitlinker\".get_buf_range_url(\"v\", {action_callback = require\"gitlinker.actions\".open_in_browser})<cr>"}) "buf range URL"]
           }
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
