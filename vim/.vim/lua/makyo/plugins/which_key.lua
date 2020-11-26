local map_tree = {
  nnoremap = {
    -- Applications ------------------------
    a = {
      name = "+applications",
      c = [":Calc<CR>",        "calculator"],
      u = [":MundoToggle<CR>", "undo tree"],
      l = {
        name = "+coc",
        c = [":CocConfig<CR>", "open coc config"],
        u = [":CocUpdate<CR>", "update coc"]
      },
      s = {
        name = "+session",
        o = [":SLoad<CR>",          "open"],
        O = [":SLoad!<CR>",         "open last session"],
        s = [":SSave<space>",       "save new"],
        u = [":SSave!<CR><CR><CR>", "save current"]
      },
      S = {
        name = "+scratchpad",
        c = [":Codi!<CR>",      "close"],
        o = [":Codi ",          "open (filetype)"],
        t = [":Codi<CR>",       "toggle"],
        u = [":CodiUpdate<CR>", "update"],
      },
      t = {
        name = "+terminal",
        c = [":FloatermNew<space>",  "run command"],
        h = [":FloatermHide<CR>",    "hide current"],
        k = [":FloatermKill<CR>",    "kill"],
        K = [":FloatermKill<space>", "kill named"],
        n = [":FloatermNext<CR>",    "next instance"],
        N = [":FloatermNew --name=", "new named terminal"],
        p = [":FloatermPrev<CR>",    "previous instance"],
        t = [":FloatermNew<CR>",     "new terminal"],
        T = {
          name = "+toggles",
          n = [":FloatermToggle ", "toggle named"],
          t = [":FloatermToggle<CR>", "toggle last"]
        }
      }
    },

    -- Buffers -----------------------------
    b = {
      name = "+buffer",
      b =       [":<C-u>Denite buffer<CR>",  "find buffer"],
      d =       [":bd<CR>",                  "delete buffer"],
      h =       [":tabnew \\| Startify<CR>", "home buffer"],
      m =       [":BufExplorer<CR>",         "manage buffers"],
      p =       [":bprevious<CR>",           "previous buffer"],
      s =       [":Scratch<CR>",             "scratch buffer"],
      "<TAB>": [":b#<CR>",                  "previous buffer"],
    },

    -- Files -------------------------------
    f = {
      name = "+files",
      c = [':let @+ = expand("%")<CR>',      "copy file path"],
      f = [":DeniteProjectDir file/rec<CR>", "find file"],
      g = ['execute "normal \<C-g>"',        "display relative path"],
      r = [":Denite file_mru<CR>",           "recent files"],
      n = {
        name = "+navigate",
        o = [":Dirvish<CR>",          "open cwd"],
        O = [":Dirvish %<CR>",        "open dir of current file"],
        v = [":vsplit \\| Dirvish<CR>", "open cwd in vertical split"],
      },
      v = {
        name = "+vim",
        k = [":tabnew ~/.vim/autoload/makyo/keymap.json5<CR>", "open keymap config"],
        p = [":tabnew ~/.vim/rc/dein.toml<CR>", "open plugin config"],
        s = [":so $MYVIMRC<CR>",     "source vimrc"],
        t = [":tabnew $MYVIMRC<CR>", "edit vimrc"]
      },
      z = {
        name = "+zsh",
        c = [":tabnew ~/.zshrc<CR>", "open .zshrc"]
      }
    },

    -- FZF ---------------------------------
    F = {
      name = "+FZF",
      b = [":FzfBuffers<CR>",  "buffers"],
      B = [":FzfBCommits<CR>", "git buffer commits"],
      c = [":FzfColors<CR>",   "color schemes"],
      f = [":FzfFiles<CR>",    "files"],
      g = [":FzfGFiles<CR>",   "files in vcs"],
      G = [":FzfGFiles?<CR>",  "git status files"],
      h = {
        name = "+history",
        C = [":FzfHistory:<CR>", "command history"],
        h = [":FzfHistory<CR>",  "mru"],
        s = [":FzfHistory/<CR>", "search history"],
      },
      l = [":FzfLines<space>",  "search lines"],
      L = [":FzfBLines<space>", "search lines in buffers"],
      m = [":FzfMarks<CR>",     "marks"],
      r = [":FzfRg<space>",     "rg search"],
      t = [":FzfTags<space>",   "tags"],
      T = [":FzfBTags<space>",  "buffer tags"],
      w = [":FzfWindows<CR>",   "windows"],
    },

    -- Mode --------------------------------
    m = {
      name = "+modes",
      l = {
        name = "+lisp",
        b = [':execute "normal " . maplocalleader . "eb"<CR>', "eval buffer"],
        e = {
          name = "+eval",
          e =   [':execute "normal " . maplocalleader . "ee"<CR>', "inner form"],
          r =   [':execute "normal " . maplocalleader . "er"<CR>', "outer form"],
          "!": [':execute "normal " . maplocalleader . "e!"<CR>', "replace with result"]
        },
        l = {
          name = "+log-buffer",
          c = [':execute "normal " . maplocalleader . "lq"<CR>', "close"],
          s = [':execute "normal " . maplocalleader . "ls"<CR>', "open horizontally"],
          v = [':execute "normal " . maplocalleader . "lv"<CR>', "open vertically"]
        }
      },
      n = {
        name = "+nodejs",
        r = [":FloatermNew node<CR>", "repl"]
      }
    },

    -- Project -----------------------------
    p = {
      name = "+project",
      b = [":DeniteProjectDir file/rec<CR>", "find project file"],
      c = {
        name = "+checks",
        t = {
          name = "+tests",
          n = [":TestNearest<CR>", "nearest"],
          f = [":TestFile<CR>",    "file"],
          s = [":TestSuite<CR>",   "suite"],
          v = [":TestVisit<CR>",   "jump to test file"]
        }
      },
      t = {
        name = "+tags",
        c = [":GenCtags<CR>", "generate ctags"],
        g = [":GenGTAGS<CR>", "generate gtags"],
        v = {
          name = "+view",
          c = [":Vista coc<CR>",     "coc"],
          C = [":Vista ctags<CR>",   "ctags"],
          f = [":Vista focus<CR>",   "focus"],
          F = [":Vista vim_lsp<CR>", "lsp"],
          t = [":Vista!!<CR>",       "toggle"]
        }
      }
    },

    -- Plugins -----------------------------
    P = {
      name = "+plugins",
      c = [":tabnew ~/.vim/rc/dein.toml<CR>", "open config"],
      r = [":call dein#remote_plugins()<CR>", "update remote plugins"],
      u = [":DeinUpdate<CR>", "update"]
    },

    -- Insertion ---------------------------
    i = {
      name = "+insertion",
      s = {
        name = "+snippets",
        c = [":CocCommand snippets.openSnippetFiles<CR>", "open snippets file"],
        e = [":CocCommand snippets.editSnippets<CR>",     "edit snippets"],
        l = [":CocList snippets<CR>",                     "list snippets"]
      }
    },

    -- Version Control ---------------------
    g = {
      name = "+version-control",
      b = {
        name = "+branch",
        l = [":Gina branch<CR>",                  "list branches"],
        i = [":Gina blame<CR>",                   "blame inline"],
        I = [":BlameToggle<CR>",                  "blame inline (blamer.nvim)"],
        m = [":Gina browse --exact :<CR>",        "open from master"],
        r = [":Gina browse --scheme=blame :<CR>", "blame in browser"]
      },
      c = {
        name = "+commit",
        a = [":Gina commit --amend<CR>",           "amend"],
        c = [":Gina commit<CR>",                   "commit"],
        m = [":Gina commit -m ",                   "simple commit"],
        n = [":Gina commit --amend --no-edit<CR>", "amend no-edit"]
      },
      d = {
        name = "+diff",
        d = [":Gina compare<CR>",           "2-buffer compare"],
        h = [":SignifyToggleHighlight<CR>", "toggle hightlight"],
        i = [":SignifyHunkDiff<CR>",        "inline diff"],
        s = [":Gina diff<CR>",              "unified diff"]
      },
      h = {
        name = "+hunks",
        u = [":SignifyHunkUndo<CR>", "undo changes"]
      },
      l = {
        name = "+logs",
        l = [":Gina log<CR>", "log"]
      },
      m = [":MergetoolToggle<CR>", "mergetool"],
      p = {
        name = "+push",
        p = [":Gina push<CR>", "push"],
        f = [":Gina push --force<CR>", "force push"]
      },
      s = [":Gina status<CR>", "status"],
      S = [":tabnew<CR>:Gina status<CR>", "status in new tab"],
      z = {
        name = "+stash",
        b = [":Gina stash<CR>",   "stash buffer"],
        s = [":Gina stash show ", "show"]
      }
    },

    -- Search ------------------------------
    s = {
      name = "+search",
      c = [":nohlsearch<CR>",               "clear highlights"],
      f = [":Farf<CR>",                     "search with Far"],
      g = [":<C-u>Denite grep:. -no-empty", "search cwd"],
      u = [":<C-u>DeniteCursorWord grep:.", "word under cursor"],
      r = {
        name = "+ripgrep",
        g = [":tabnew \\| :Rg -i", "rg"]
      },
      s = {
        name = "+replace",
        s = [":Farr<CR>", "replace"]
      }
    },

    -- More sane regexes
    "/": "/\\v",
    "?": "?\\v",
    "s/": "s/\\v",

    -- Text --------------------------------
    -- - --> Delete the current line
    -- Q --> Don't use Ex mode, use Q for formatting
    -- Y --> Make Y behave like other capital letters
    ----------------------------------------
    "-": "dd",
    Q = "gq",
    Y = "y$",

    -- Text --------------------------------
    x = {
      name = "+text",
      a = [":EasyAlign", "align text"],
      t = {
        name = "+table-mode",
        f = {
          name = "+formulas",
          e = [":TableEvalFormulaLine", "eval formula"],
          f = [":TableAddFormula",      "add cell formula"]
        },
        r = [":TableModeRealign",    "realign"],
        t = [":TableModeToggle<CR>", "toggle"]
      }
    },

    -- Toggles -----------------------------
    t = {
      name = "+toogles",
      c = [":Denite colorscheme", "cycle color schemes"]
    },

    -- Windows -----------------------------
    -- Easier window navigation
    -- Ctrl + h --> Go to window left of current
    -- Ctrl + j --> Go to window below current
    -- Ctrl + k --> Go to window above current
    -- Ctrl + l --> Go to window right of current
    ----------------------------------------
    "<C-h>": "<C-w>h",
    "<C-j>": "<C-w>j",
    "<C-k>": "<C-w>k",
    "<C-l>": "<C-w>l",

    w = {
      name = "+windows",
      a =   [":windo q<CR>",      "close all windows"],
      s =   [":exe 'split'<CR>",  "horizontal split"],
      v =   [":exe 'vsplit'<CR>", "vertical split"],
      c =   [":close<CR>",        "close current window"],
      l =   [":lopen<CR>",        "open location list"],
      q =   [":copen<CR>",        "open quickfix"],
      W =   ["<Plug>(choosewin)", "jump to window"],
      "+": [":resize +5<CR>",    "increase height"],
      "-": [":resize -5<CR>",    "decrease height"]
    }
  },

  noremap = {
    -- Easier navigation on line-wrapped text
    j = "gj",
    k = "gk",
    gj: "j",
    gk: "k",

    tc: ":tabnew<CR>"
  },

  cnoremap = {
    -- Heretical mappings
    -- Ctrl + a --> Jump to beginning of line
    -- Ctrl + b --> Back one character
    -- Ctrl + d --> Delete one character
    -- Ctrl + e --> Jump to end of line
    -- Ctrl + f --> Forward one character
    -- Ctrl + n --> Go forwards in history to the a newer entry
    -- Ctrl + p --> Go backwards in history to an older entry
    ----------------------------------------
    "<C-A>": "<Home>",
    "<C-B>": "<Left>",
    "<C-D>": "<Del>",
    "<C-E>": "<End>",
    "<C-F>": "<Right>",
    "<C-N>": "<Down>",
    "<C-P>": "<Up>",

    -- More sane regexes
    "s/": "s/\\v",
    "%s/": "%s/\\v",

    -- Using sudo to write to a file
    "w!!": "w !sudo tee % >/dev/null"
  },

  inoremap = {
    -- jk --> Escape from insert mode without stretching your fingers
    -- Ctrl + U --> CTRL-U in insert mode deletes a lot. Use CTRL-G u to first break undo,
    --              so that you can undo CTRL-U after inserting a line break.
    -- Ctrl + d --> Delete text after the cusor position in insert mode.
    ----------------------------------------
    jk: "<ESC>",
    "<C-U>": "<C-G>u<C-U>",
    "<C-d>": "<C-[>ld$A",

    -- coc.nvim snippets - see https://github.com/neoclide/coc.nvim/wiki/Using-snippets
    "<silent><expr> <CR>": 'pumvisible() ? coc#_select_confirm() : "<C-g>u<CR><c-r>=coc#on_enter()<CR>"'
  },

  snoremap = {},

  tnoremap = {
    -- Navigate windows from the terminal using Alt + h/j/k/l
    "<A-h>": "<C-><C-N><C-w>h",
    "<A-j>": "<C-><C-N><C-w>j",
    "<A-k>": "<C-><C-N><C-w>k",
    "<A-l>": "<C-><C-N><C-w>l",

    -- Simulate i_CTRL-R for inserting the contents of a register
    "<expr> <C-R>": "'<C-><C-N>\"' . nr2char(getchar()) . 'pi'",

    -- Exit terminal mode easily
    "<Esc>": "<C-><C-N>",
    "<M-[>": "<Esc>",
    "<C-v><Esc>": "<Esc>"
  },

  vnoremap = {
    -- More sane regexes
    "/":   "/\\v",
    "?":   "?\\v",
    "s/":  "s/\\v",
    "%s/": "%s/\\v",

    "<leader>*": ":<C-u>call VisualStarSearchSet('/', 'raw')<CR>:call ag#Ag('grep', '--literal ' . shellescape(@/))<CR>",

    "m": {
      name = "+modes",
      l = {
        name = "+lisp",
        c = [':execute "normal gv" . maplocalleader . "Ea("<CR>', "eval form"],
        E = [':execute "normal gv" . maplocalleader . "E"<CR>',   "eval selection"],
        w = [':execute "normal gv" . maplocalleader . "Eiw"<CR>', "eval word"]
      },
    },

    "s": {
      "name": "+search",
      f = [":Farf<CR>", "search with Far"],
      s = {
        name = "+replace",
        s = [":Farr<CR>", "replace"]
      }
    }
  },

  map = {
    -- Comment/Compile ---------------------
    c = {
      name = "+comments/compile",
      c = ["<plug>NERDCommenterToggle",    "comment one line"],
      s = ["<plug>NERDCommenterSexy",      "comment sexily"],
      u = ["<plug>NERDCommenterUncomment", "uncomment"]
    },

    -- Version Control ---------------------
    g = {
      name = "+version-control",
      l = {
        name = "+logs",
        c = ["<Plug>(git-messenger)",            "last commit message"],
        p = ["<Plug>(git-messenger-into-popup)", "open popup"]
      },
      h = {
        name = "+hunks",
          n = ["<Plug>(signify-next-hunk)", "next"],
          p = ["<Plug>(signify-prev-hunk)", "prev"]
      }
    },

    -- Jumps/Folds -------------------------
    j = {
      name = "+jumps/folds",
      a = {
        name = "+ale",
        d = ["<Plug>(ale_go_to_definition)", "definition"],
        r = ["<Plug>(ale_find_references)", "references"],
        t = ["<Plug>(ale_go_to_type_definition)", "type definition"],
        R = [":ALERename<CR>", "rename symbol"]
      },
      c = {
        name = "+coc",
        d = ["<Plug>(coc-definition)", "definition"],
        D = ["<Plug>(coc-declaration)", "declaration"],
        i = ["<Plug>(coc-implementation)", "implementation"],
        o = ["<Plug>(coc-openlink)", "open link"],
        r = ["<Plug>(coc-references)", "references"],
        R = ["<Plug>(coc-rename)", "rename symbol"],
        t = ["<Plug>(coc-type-definition)", "type definition"],
        e = {
          name = "+errors/diagnostics",
          n = ["<Plug>(coc-diagnostic-next)", "next diagnostic"],
          N = ["<Plug>(coc-diagnostic-next-error)", "next error"],
          p = ["<Plug>(coc-diagnostic-prev)", "prev diagnostic"],
          P = ["<Plug>(coc-diagnostic-prev-error)", "prev error"]
        }
      },
      j = ["<Plug>(easymotion-s)", "easymotion"],
      e = {
        name = "+errors",
        f = ["<Plug>(ale_fix)",  "fix"],
        n = ["<Plug>(ale_next_wrap)", "next"],
        p = ["<Plug>(ale_prev_wrap)", "previous"]
      },
      z = {
        name = "+folds",
        "0": [":set foldlevel=0", "level 0"],
        "1": [":set foldlevel=1", "level 1"],
        "2": [":set foldlevel=2", "level 2"],
        "3": [":set foldlevel=3", "level 3"],
        "4": [":set foldlevel=4", "level 4"],
        "5": [":set foldlevel=5", "level 5"],
        "6": [":set foldlevel=6", "level 6"],
        "7": [":set foldlevel=7", "level 7"],
        "8": [":set foldlevel=8", "level 8"],
        "9": [":set foldlevel=9", "level 9"]
      }
    },

    -- Windows -----------------------------
    w = {
      name = "+windows",
      W = ["<Plug>(choosewin)", "jump to window"]
    },

    -- Maintain ; and , functionality with clever-f plugin
    ";": "<Plug>(clever-f-repeat-forward)",
    ",": "<Plug>(clever-f-repeat-back)"
  },

  nmap = {
    -- Start interactive EasyAlign for a motion/text object (e.g. gaip)
    -- "ga": "<Plug>(EasyAlign)",
    "<Tab>": [":b#<CR>", "previous buffer"],
  },

  imap = {
    "<C-l>": "<Plug>(coc-snippets-expand)",
    "<C-j>": "<Plug>(coc-snippets-expand-jump)"
  },

  smap = {},

  vmap = {
    -- Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
    "<Enter>": "<Plug>(EasyAlign)",
    "<C-j>": "<Plug>(coc-snippets-select)"
  }
}

local function setup()
  local leader_map = {
    -- a = applications,
    -- b = buffers,
    -- c = comments_compile,
    -- f = files,
    -- F = fzf,
    -- g = version_control,
    -- i = insertion,
    -- j = jump_folds,
    -- m = modes,
    -- p = project,
    -- P = plugins,
    -- s = search,
    -- t = toggles,
    -- x = text
  }
  leader_map['<Tab>'] = 'previous buffer'

  leader_map['*']     = 'which_key_ignore'
  leader_map['x']     = 'which_key_ignore'
  leader_map['p']     = 'which_key_ignore'
  leader_map['pb']    = 'which_key_ignore'

  set_comments_compile_maps()
  set_version_control_mappings()

  return leader_map
end

return { setup = setup }
