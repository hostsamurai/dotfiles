;;;; Configures usability options
(module makyo-fnl.ux
  {require {a aniseed.core
            nvim aniseed.nvim}})

(defn- setup_basic_options []
  (let [o nvim.o
        home_dir (os.getenv "HOME")
        backup_dir (.. home_dir "/.vim/backups")
        undo_dir (.. home_dir "/.vim/undo")
        tmp_dir (.. home_dir "/.vim/tmp")]
    (do 
      ;; keep a backup file 
      (set o.backup          true) 
      (set o.backupdir       backup_dir)
      (set o.directory       tmp_dir)
      (set o.writebackup     true)
      ;; improve scrolling performance when navigating through large results  
      (set o.lazyredraw      true) 
      ;; round indentation values to multiples of shiftwidth  
      (set o.shiftround      true) 
      (set o.shiftwidth      2)
      (set o.tabstop         2)
      (set o.softtabstop     2)
      ;; wrap long lines  
      (set o.linebreak       true) 
      (set o.matchpairs      "(:),{:},[:],<:>")
      (set o.wrap            true)
      ;; command line height  
      (set o.cmdheight       2) 
      ;; show line numbers relative to the current line  
      (set o.relativenumber  true) 
      ;; show effects of a command as you type  
      (set o.inccommand      "nosplit") 
      (set o.sessionoptions  "resize,winpos,winsize,buffers,tabpages,folds,curdir,localoptions,help")

      ;; Enable persistent undo so that undo history persists across sessions
      (set o.undofile        true)
      (set o.undodir         undo_dir)
      ;; Hide the tabline 
      (set o.showtabline     0)
      ;; turn tabs into spaces 
      (set o.expandtab       true)
      (set o.formatoptions   "tcqrn")

      ;; Don't attempt to highlight lines > 800 characters
      (set o.synmaxcol       800)

      (set o.foldlevelstart  99)

      ;; Better completion
      (set o.complete        ".,w,b,u,t")
      (set o.completeopt     "longest,menuone,preview")

      ;; Use ripgrep instead of regular grep 
      (set o.grepprg         "rg")

      ;; Wildmenu completion
      (local wildignore_list [
                             "*.swp"   ".class" ".pyc" ".zip"
                             "*/tmp/*"  "*.o"   "*.obj" "*.so"  ;; unix
                             ".hg"      ".git"  ".svn"          ;; version control
                             "*.jpg"   "*.jpeg" "*.gif" "*.png" ;; binary images
                             ])
      (set o.wildignore (table.concat wildignore_list ","))

      ;; Tag options
      (set o.tags "./tags;${HOME}"))))

(defn init []
  (do
    (a.println "[makyo] 🔨 Applying UX settings...")
    (setup_basic_options)
    (a.println "[makyo] 🔨 Done.")))
