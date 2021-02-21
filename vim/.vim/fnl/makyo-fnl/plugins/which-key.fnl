;;;; Layer configuration

(module makyo-fnl.plugins.which-key
  {require {a aniseed.core
            nvim aniseed.nvim
            translator makyo.plugins.translator}})

;; Convinience function for creating custom mappings
(defn- modemap [mode noremap cmd]
  (let [m (if (= noremap true)
               "noremap"
               "map")
        opts (if (= noremap true)
               [:silent]
               [])
        fullmode (.. mode m)
        modefn (a.get vimp fullmode)]
    (fn [chord]
      (modefn opts (.. "<leader>" chord) cmd))))

(def- n  (partial modemap "n" false))
(def- nn (partial modemap "n" true))
(def- vn (partial modemap "v" true))

(def- layers {
  ;; Applications ------------------------
  :a {
    :name "+applications"
    :c [(nn ":Calc<CR>")        "calculator"]
    :u [(nn ":MundoToggle<CR>") "undo tree"]
    :l {
      :name "+coc"
      :c [(nn ":CocConfig<CR>") "open coc config"]
      :u [(nn ":CocUpdate<CR>") "update coc"]
    }
    :s {
      :name "+session"
      :o [(nn ":SLoad<CR>")          "open"]
      :O [(nn ":SLoad!<CR>")         "open last session"]
      :s [(nn ":SSave<space>")       "save new"]
      :u [(nn ":SSave!<CR><CR><CR>") "save current"]
    }
    :S {
      :name "+scratchpad"
      :c [(nn ":Codi!<CR>")      "close"]
      :o [(nn ":Codi ")          "open (filetype)"]
      :t [(nn ":Codi<CR>")       "toggle"]
      :u [(nn ":CodiUpdate<CR>") "update"]
    }
    :t {
      :name "+terminal"
      :c [(nn ":FloatermNew<space>")  "run command"]
      :h [(nn ":FloatermHide<CR>")    "hide current"]
      :k [(nn ":FloatermKill<CR>")    "kill"]
      :K [(nn ":FloatermKill<space>") "kill named"]
      :n [(nn ":FloatermNext<CR>")    "next instance"]
      :N [(nn ":FloatermNew --name=") "new named terminal"]
      :p [(nn ":FloatermPrev<CR>")    "previous instance"]
      :t [(nn ":FloatermNew<CR>")     "new terminal"]
      :T {
        :name "+toggles"
        :n [(nn ":FloatermToggle ")    "toggle named"]
        :t [(nn ":FloatermToggle<CR>") "toggle last"]
      }
    }
  }

  ;; Buffers -----------------------------
  :b {
    :name "+buffer"
    :b          [(nn ":<C-u>Denite buffer<CR>")  "find buffer"]
    :d          [(nn ":bd<CR>")                  "delete buffer"]
    :h          [(nn ":tabnew \\| Startify<CR>") "home buffer"]
    :m          [(nn ":BufExplorer<CR>")         "manage buffers"]
    :p          [(nn ":bprevious<CR>")           "previous buffer"]
    :s          [(nn ":Scratch<CR>")             "scratch buffer"]
    "<TAB>"     [(nn ":b#<CR>")                  "previous buffer"]
  }

  ;; Comment/Compile ---------------------
  :c {
    :name "+comments/compile"
    :c [(n "<plug>NERDCommenterToggle")    "comment one line"]
    :s [(n "<plug>NERDCommenterSexy")      "comment sexily"]
    :u [(n "<plug>NERDCommenterUncomment") "uncomment"]
  }

  ;; Files -------------------------------
  :f {
    :name "+files"
    :c [(nn ":let @+ = expand('%')<CR>")      "copy file path"]
    :f [(nn ":DeniteProjectDir file/rec<CR>") "find file"]
    :g [(nn "execute 'normal <C-g>'")         "display relative path"]
    :r [(nn ":Denite file_mru<CR>")           "recent files"]
    :n {
      :name "+navigate"
      :o [(nn ":Dirvish<CR>")          "open cwd"]
      :O [(nn ":Dirvish %<CR>")        "open dir of current file"]
      :v [(nn ":vsplit | Dirvish<CR>") "open cwd in vertical split"]
    }
    :v {
      :name "+vim"
      :i [(nn ":tabnew ~/.vim/fnl/makyo-fnl/ui.fnl<CR>")                "open UI config"]
      :k [(nn ":tabnew ~/.vim/fnl/makyo-fnl/mappings.fnl<CR>")          "open keymap config"]
      :p [(nn ":tabnew ~/.vim/lua/makyo/plugins/setup.lua<CR>")         "open plugin config"]
      :t [(nn ":tabnew $MYVIMRC<CR>")                                   "edit vimrc"]
      :u [(nn ":tabnew ~/.vim/fnl/makyo-fnl/ux.fnl<CR>")                "open UX config"]
      :w [(nn ":tabnew ~/.vim/fnl/makyo-fnl/plugins/which-key.fnl<CR>") "open which_key config"]
    }
    :z {
      :name "+zsh"
      :c [(nn ":tabnew ~/.zshrc<CR>") "open .zshrc"]
    }
  }

  ;; FZF ---------------------------------
  :F {
    :name "+FZF"
    :b [(nn ":FzfBuffers<CR>")  "buffers"]
    :B [(nn ":FzfBCommits<CR>") "git buffer commits"]
    :c [(nn ":FzfColors<CR>")   "color schemes"]
    :f [(nn ":FzfFiles<CR>")    "files"]
    :g [(nn ":FzfGFiles<CR>")   "files in vcs"]
    :G [(nn ":FzfGFiles?<CR>")  "git status files"]
    :h {
      :name "+history"
      :C [(nn ":FzfHistory:<CR>") "command history"]
      :h [(nn ":FzfHistory<CR>")  "mru"]
      :s [(nn ":FzfHistory/<CR>") "search history"]
    }
    :l [(nn ":FzfLines<space>")  "search lines"]
    :L [(nn ":FzfBLines<space>") "search lines in buffers"]
    :m [(nn ":FzfMarks<CR>")     "marks"]
    :r [(nn ":FzfRg<space>")     "rg search"]
    :t [(nn ":FzfTags<space>")   "tags"]
    :T [(nn ":FzfBTags<space>")  "buffer tags"]
    :w [(nn ":FzfWindows<CR>")   "windows"]
  }

  ;; Version Control ---------------------
  :g {
    :name "+version-control"
    :b {
      :name "+branch"
      :l [(nn ":Gina branch<CR>")                  "list branches"]
      :i [(nn ":Gina blame<CR>")                   "blame inline"]
      :I [(nn ":BlameToggle<CR>")                  "blame inline (blamer.nvim)"]
      :m [(nn ":Gina browse --exact :<CR>")        "open from master"]
      :r [(nn ":Gina browse --scheme=blame :<CR>") "blame in browser"]
    }
    :c {
      :name "+commit"
      :a [(nn ":Gina commit --amend<CR>")           "amend"]
      :c [(nn ":Gina commit<CR>")                   "commit"]
      :m [(nn ":Gina commit -m ")                   "simple commit"]
      :n [(nn ":Gina commit --amend --no-edit<CR>") "amend no-edit"]
    }
    :d {
      :name "+diff"
      :d [(nn ":Gina compare<CR>")           "2-buffer compare"]
      :h [(nn ":SignifyToggleHighlight<CR>") "toggle hightlight"]
      :i [(nn ":SignifyHunkDiff<CR>")        "inline diff"]
      :s [(nn ":Gina diff<CR>")              "unified diff"]
    }
    :h {
      :name "+hunks"
      :n [(n "<Plug>(signify-next-hunk)") "next"]
      :p [(n "<Plug>(signify-prev-hunk)") "prev"]
      :u [(nn ":SignifyHunkUndo<CR>")     "undo changes"]
    }
    :l {
      :name "+logs"
      :c [(n  "<Plug>(git-messenger)")            "last commit message"]
      :l [(nn ":Gina log<CR>")                    "log"]
      :p [(n  "<Plug>(git-messenger-into-popup)") "open popup"]
    }
    :m [(nn ":MergetoolToggle<CR>") "mergetool"]
    :p {
      :name "+push"
      :p [(nn ":Gina push<CR>") "push"]
      :f [(nn ":Gina push --force<CR>") "force push"]
    }
    :s [(nn ":Gina status<CR>") "status"]
    :S [(nn ":tabnew<CR>:Gina status<CR>") "status in new tab"]
    :z {
      :name "+stash"
      :b [(nn ":Gina stash<CR>")   "stash buffer"]
      :s [(nn ":Gina stash show ") "show"]
    }
  }

  ;; Insertion ---------------------------
  :i {
    :name "+insertion"
    :s {
      :name "+snippets"
      :c [(nn ":CocCommand snippets.openSnippetFiles<CR>") "open snippets file"]
      :e [(nn ":CocCommand snippets.editSnippets<CR>")     "edit snippets"]
      :l [(nn ":CocList snippets<CR>")                     "list snippets"]
    }
  }

  ;; Jumps/Folds -------------------------
  :j {
    :name "+jumps/folds"
    :a {
      :name "+ale"
      :d [(n "<Plug>(ale_go_to_definition)")      "definition"]
      :r [(n "<Plug>(ale_find_references)")       "references"]
      :t [(n "<Plug>(ale_go_to_type_definition)") "type definition"]
      :R [(n ":ALERename<CR>")                    "rename symbol"]
    }
    :c {
      :name "+coc"
      :d [(n "<Plug>(coc-definition)")      "definition"]
      :D [(n "<Plug>(coc-declaration)")     "declaration"]
      :i [(n "<Plug>(coc-implementation)")  "implementation"]
      :o [(n "<Plug>(coc-openlink)")        "open link"]
      :r [(n "<Plug>(coc-references)")      "references"]
      :R [(n "<Plug>(coc-rename)")          "rename symbol"]
      :t [(n "<Plug>(coc-type-definition)") "type definition"]
      :e {
        :name "+errors/diagnostics"
        :n [(n "<Plug>(coc-diagnostic-next)")       "next diagnostic"]
        :N [(n "<Plug>(coc-diagnostic-next-error)") "next error"]
        :p [(n "<Plug>(coc-diagnostic-prev)")       "prev diagnostic"]
        :P [(n "<Plug>(coc-diagnostic-prev-error)") "prev error"]
      }
    }
    :j [(n "<Plug>(easymotion-s)") "easymotion"]
    :e {
      :name "+errors"
      :f [(n "<Plug>(ale_fix)")       "fix"]
      :n [(n "<Plug>(ale_next_wrap)") "next"]
      :p [(n "<Plug>(ale_prev_wrap)") "previous"]
    }
    :z {
      :name "+folds"
      "0" [(n ":set foldlevel=0") "level 0"]
      "1" [(n ":set foldlevel=1") "level 1"]
      "2" [(n ":set foldlevel=2") "level 2"]
      "3" [(n ":set foldlevel=3") "level 3"]
      "4" [(n ":set foldlevel=4") "level 4"]
      "5" [(n ":set foldlevel=5") "level 5"]
      "6" [(n ":set foldlevel=6") "level 6"]
      "7" [(n ":set foldlevel=7") "level 7"]
      "8" [(n ":set foldlevel=8") "level 8"]
      "9" [(n ":set foldlevel=9") "level 9"]
    }
  }

  ;; Mode --------------------------------
  :m {
    :name "+modes"
    :l {
      :name "+lisp"
      :b [(nn ":execute 'normal ' . maplocalleader . 'eb'<CR>") "eval buffer"]
      :e {
        :name "+eval"
        :c  [(vn ":execute 'normal gv' . maplocalleader . 'Ea('<CR>") "eval form"]
        :E  [(vn ":execute 'normal gv' . maplocalleader . 'E'<CR>")   "eval selection"]
        :w  [(vn ":execute 'normal gv' . maplocalleader . 'Eiw'<CR>") "eval word"]
        :e  [(nn ":execute 'normal ' . maplocalleader . 'ee'<CR>")    "inner form"]
        :r  [(nn ":execute 'normal ' . maplocalleader . 'er'<CR>")    "outer form"]
        "!" [(nn ":execute 'normal ' . maplocalleader . 'e!'<CR>")    "replace with result"]
      }
      :l {
        :name "+log-buffer"
        :c [(nn ":execute 'normal ' . maplocalleader . 'lq'<CR>") "close"]
        :s [(nn ":execute 'normal ' . maplocalleader . 'ls'<CR>") "open horizontally"]
        :v [(nn ":execute 'normal ' . maplocalleader . 'lv'<CR>") "open vertically"]
      }
    }
    :n {
      :name "+nodejs"
      :r [(nn ":FloatermNew node<CR>") "repl"]
    }
  }

  ;; Project -----------------------------
  :p {
    :name "+project"
    :b [(nn ":DeniteProjectDir file/rec<CR>") "find project file"]
    :c {
      :name "+checks"
      :t {
        :name "+tests"
        :n [(nn ":TestNearest<CR>") "nearest"]
        :f [(nn ":TestFile<CR>")    "file"]
        :s [(nn ":TestSuite<CR>")   "suite"]
        :v [(nn ":TestVisit<CR>")   "jump to test file"]
      }
    }
    :t {
      :name "+tags"
      :c [(nn ":GenCtags<CR>") "generate ctags"]
      :g [(nn ":GenGTAGS<CR>") "generate gtags"]
      :v {
        :name "+view"
        :c [(nn ":Vista coc<CR>")     "coc"]
        :C [(nn ":Vista ctags<CR>")   "ctags"]
        :f [(nn ":Vista focus<CR>")   "focus"]
        :F [(nn ":Vista vim_lsp<CR>") "lsp"]
        :t [(nn ":Vista!!<CR>")       "toggle"]
      }
    }
  }

  ;; Plugins -----------------------------
  :P {
    :name "+plugins"
    :c [(nn ":PackerCompile<CR>") "compile changes"]
    :o [(nn ":tabnew ~/.vim/lua/makyo/plugins/setup.lua<CR>") "open config"]
    :u [(nn ":PackerUpdate<CR>") "update"]
  }

  ;; Search ------------------------------
  :s {
    :name "+search"
    :c [(nn ":nohlsearch<CR>")               "clear highlights"]
    :f [(nn ":Farf<CR>")                     "search with Far"]
    :g [(nn ":<C-u>Denite grep:. -no-empty") "search cwd"]
    :u [(nn ":<C-u>DeniteCursorWord grep:.") "word under cursor"]
    :r {
      :name "+ripgrep"
      :g [(nn ":tabnew \\| :Rg -i") "rg"]
    }
    :s {
      :name "+replace"
      :s [(nn ":Farr<CR>") "replace"]
    }
  }

  ;; Toggles -----------------------------
  :t {
    :name "+toogles"
    :c [(nn ":Denite colorscheme") "cycle color schemes"]
  }

  ;; Windows -----------------------------
  :w {
    :name "+windows"
    :a    [(nn ":windo q<CR>")      "close all windows"]
    :s    [(nn ":exe 'split'<CR>")  "horizontal split"]
    :v    [(nn ":exe 'vsplit'<CR>") "vertical split"]
    :c    [(nn ":close<CR>")        "close current window"]
    :l    [(nn ":lopen<CR>")        "open location list"]
    :q    [(nn ":copen<CR>")        "open quickfix"]
    :W    [(n  "<Plug>(choosewin)") "jump to window"]
    "+"   [(nn ":resize +5<CR>")    "increase height"]
    "-"   [(nn ":resize -5<CR>")    "decrease height"]
  }

  ;; Text --------------------------------
  :x {
    :name "+text"
    :a [(nn ":EasyAlign") "align text"]
    :t {
      :name "+table-mode"
      :f {
        :name "+formulas"
        :e [(nn ":TableEvalFormulaLine") "eval formula"]
        :f [(nn ":TableAddFormula")      "add cell formula"]
      }
      :r [(nn ":TableModeRealign")    "realign"]
      :t [(nn ":TableModeToggle<CR>") "toggle"]
    }
  }
})

(defn setup []
  (let [ignore-list ["*"]
        mapped-cmds (translator.init layers)]
    (a.assoc mapped-cmds "<TAB>" "previous buffer")
    (a.map (fn [k] (a.assoc mapped-cmds k "which_key_ignore")) ignore-list)
    mapped-cmds))
