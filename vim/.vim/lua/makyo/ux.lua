--- Basic usability settings
-- @module

local o = vim.o

local home_dir  = os.getenv('HOME')
local backupdir = home_dir .. '/.vim/backups'
local undodir   = home_dir .. "/.vim/undo"
local tmpdir    = home_dir .. '/.vim/tmp'

--- Set up initial settings
local function setup_basic_options()
  o.backup         = true      -- keep a backup file
  o.backupdir      = backupdir
  o.directory      = tmpdir
  o.writebackup    = true
  o.lazyredraw     = true      -- improve scrolling performance when navigating through large results
  o.shiftround     = true      -- round indentation values to multiples of shiftwidth
  o.shiftwidth     = 2
  o.tabstop        = 2
  o.softtabstop    = 2
  o.linebreak      = true      -- wrap long lines
  o.matchpairs     = "(:),{:},[:],<:>"
  o.cmdheight      = 2         -- command line height
  o.relativenumber = true      -- show line numbers relative to the current lien
  o.inccommand     = "nosplit" -- show effects of a command as you type
  o.sessionoptions = "resize,winpos,winsize,buffers,tabpages,folds,curdir,localoptions,help"

  -- Enable persistent undo so that undo history persists across sessions
  o.undofile       = true
  o.undodir        = undodir

  o.showtabline    = 0         -- Hide the tabline

  o.expandtab      = true      -- turn tabs into spaces
  o.formatoptions  = "tcqrn"

  -- Don't attempt to highlight lines > 800 characters
  o.synmaxcol      = 800

  o.foldlevelstart = 99

  -- Better completion
  o.complete       = ".,w,b,u,t"
  o.completeopt    = "longest,menuone,preview"

  o.grepprg        = "rg"      -- Use ripgrep instead of regular grep

  -- Wildmenu completion
  local wildignore_list = {
    "*.swp", ".class", ".pyc", ".zip",
    "*/tmp/*", "*.o", "*.obj", "*.so",  -- unix
    ".hg", ".git", ".svn",              -- version control
    "*.jpg", "*.jpeg", "*.gif", "*.png" -- binary images
  }
  o.wildignore = table.concat(wildignore_list, ",")

  -- Tag options
  o.tags = "./tags;${HOME}"
end

--- Initialize options and autogroups
local function init()
  print "[makyo] 🔨 Applying UX settings..."

  setup_basic_options()
  -- NOTE: augroups moved to plugin/makyo.vim

  print "[makyo] 🔨 Done."
end

return {
  init = init
}
