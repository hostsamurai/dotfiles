--- Main plugin configuration using packer.nvim
-- @module setup

vim.g.loaded_aniseed = false

local general_purpose_plugins = {
  -- Let packer manage itself as an optional plugin
  'wbthomason/packer.nvim',

  {
    'liuchengxu/vim-better-default',
    opt = false,
    config = function()
      vim.g.vim_better_default_key_mapping = 0
      vim.g.vim_better_default_persistent_undo = 1
    end
  },

  {
    'liuchengxu/vim-which-key',
    opt = false,
    -- Before loading the plugin
    setup = function()
      vim.g.which_key_align_by_separator = 1
      vim.g.which_key_use_floating_win = 1
      vim.g.which_key_timeout = 500
    end,
    config = function()
      vim.fn['which_key#register']('<Space>', 'g:which_key_map')
    end,
    rocks = 'tl'
  },

  'skywind3000/asynctasks.vim'
}

local coding_plugins = {
  { 
    'neoclide/coc.nvim',  
    branch = 'release',
    setup = function()
      vim.g.coc_snippet_next = '<c-j>'
      vim.g.coc_snippet_prev = '<c-k>'
    end
  },

  'jsfaint/gen_tags.vim',
  'liuchengxu/vista.vim',

  'honza/vim-snippets',
  'Shougo/context_filetype.vim',

  { 
    'justinmk/vim-dirvish',
    setup = function()
      vim.g.dirvish_mode = [[:sort ,^.*[\/],]]
    end
  },
  -- Show git status flags along Dirvish
  'kristijanhusak/vim-dirvish-git',
  -- List all files defined by your projections with the Dirvish plugin
  'fsharpasharp/vim-dirvinist',

  { 
    'scrooloose/nerdcommenter',
    setup = function()
      vim.g.NERDSpaceDelim = 0
      vim.g.NERDTrimTrailingWhitespace = 1
    end
  },

  { 
    'dense-analysis/ale',
    setup = function()
      vim.g['airline#extensions#ale#enabled'] = 1
      vim.g.ale_disable_lsp = 1
      vim.g.ale_set_balloons = 1
      vim.g.ale_fix_on_save = 1
      vim.g.ale_fixers = {
        ['*'] = {'remove_trailing_lines', 'trim_whitespace'}
      }
    end
  },

  { 
    'editorconfig/editorconfig-vim',
    setup = function()
      vim.g.EditorConfig_exclude_patterns = {'fugitive://.*'}
      vim.g.EditorConfig_core_mode = 'external_command'
    end
  },

  'tpope/vim-endwise',
  'tpope/vim-classpath',
  'tpope/vim-repeat',
  'amix/open_file_under_cursor.vim',
  'tpope/vim-dispatch',
  'vim-test/vim-test',
  'tpope/vim-projectionist',

  { 
    'rrethy/vim-hexokinase',
    run = 'make hexokinase',
    setup = function()
      vim.g.all_hexokinase_patterns = {
        'full_hex', 
        'triple_hex', 
        'rgb', 
        'rgba', 
        'hsl', 
        'hsla'
      }
      vim.g.Hexokinase_ftOptInPatterns = {
        css     = vim.g.all_hexokinase_patterns,
        less    = vim.g.all_hexokinase_patterns,
        scss    = vim.g.all_hexokinase_patterns,
        sass    = vim.g.all_hexokinase_patterns,
        clojure = 'full_hex,triple_hex,hsl,hsla'
      }
      vim.g.Hexokinase_ftEnabled  = {'css', 'less', 'sass', 'scss', 'clojure'}
      vim.g.Hexokinase_ftDisabled = {'help'}
    end
  },

  'mattn/emmet-vim'
}

local text_manipulation_plugins = {
  'terryma/vim-multiple-cursors',
  't9md/vim-textmanip',
  'tpope/vim-speeddating',
  'tpope/vim-surround',
  'vim-scripts/visincr',

  { 
    'losingkeys/vim-niji',
    ft = {
      'lisp', 
      'scheme', 
      'clojure', 
      'fennel', 
      'janet'
    },
    setup = function()
      vim.g.niji_matching_filetypes = {
        'lisp', 
        'scheme', 
        'clojure', 
        'fennel', 
        'janet'
      }
    end
  },

  { 
    'AndrewRadev/switch.vim',
    cmd = 'Switch',
    setup = function()
      -- TODO: Get rid of this
      vim.g.switch_mapping = '<Space>tt'
    end
  },

  'junegunn/vim-easy-align',
  'wellle/targets.vim',
  'rhysd/clever-f.vim',

  { 
    'dhruvasagar/vim-table-mode',
    opt = true,
    cmd = { 'TableModeToggle', 'TableModeEnable', 'Tableize' }
  },

  { 
    'dkarter/bullets.vim', 
    setup = function()
      vim.g.bullets_set_mappings = 0
    end
  }
}

local language_plugins = {
  -- Ultimate syntax collection
  { 
    'sheerun/vim-polyglot',
    config = function()
      vim.g.javascript_plugin_jsdoc = 1
      vim.g.jscomplete_use = {'dom', 'moz', 'es6th'}
      vim.g.clojure_align_multiline_strings = 0
    end
  },

  {'tpope/vim-fireplace', ft = 'clojure'},
  {'dgrnbrg/vim-redl', ft = 'clojure'},
  {'clojure-vim/acid.nvim', ft = 'clojure'},

  'bakpakin/fennel.vim',
  'Olical/nvim-local-fennel',
  {
    'Olical/aniseed', 
    config = function() vim.g.loaded_aniseed = true end
  },
  {
    'Olical/conjure',
    ft = {'clojure', 'scheme', 'racket', 'chicken', 'fennel'},
    setup = function()
      vim.g['conjure#client#fennel#aniseed#aniseed_module_prefix'] = "aniseed."
    end
  },

  {
    'kovisoft/paredit',
    ft = {'clojure', 'scheme', 'racket', 'chicken', 'fennel'},
    setup = function()
      vim.g.paredit_mode = 1
      vim.g.paredit_shortmaps = 1
      vim.g.paredit_smartjump = 1
      vim.g.paredit_leader = ','
    end
  },

  {'guileen/vim-node', ft = 'javascript'},
  {'myhere/vim-nodejs-complete', ft = 'javascript'},
  {
    'prettier/vim-prettier',
    run = 'npm install --frozen-lockfile --production',
    ft = {
      'javascript', 
      'typescript', 
      'typescriptreact',
      'less', 
      'css', 
      'scss', 
      'json', 
      'graphql', 
      'markdown', 
      'yaml', 
      'html'
    },
    config = function()
      vim.api.nvim_del_keymap('n', '<leader>p')
    end
  },

  {'tpope/vim-rails', ft = 'ruby'},

  -- Lua
  'tjdevries/nlua.nvim',
  {'nvim-lua/completion-nvim', ft = 'lua'},
  -- Path, context manager, unit testing and luarocks installation functions
  'nvim-lua/plenary.nvim',
  {'euclidianAce/BetterLua.vim', ft = 'lua'},
  {'tjdevries/manillua.nvim', ft = 'lua'},
  'svermeulen/vimpeccable',
  {'bfredl/nvim-luadev', ft = 'lua'},

  'teal-language/vim-teal',

  {
    'iamcco/markdown-preview.nvim', 
    ft = {'markdown', 'pandoc.markdown', 'rmd'},
    run = 'cd app && yarn install'
  },

  -- An interactive scratchpad
  'metakirby5/codi.vim'
}

local application_plugins = {
  'gregsexton/VimCalc',
  'simnalamburt/vim-mundo',

  {
    'LucHermitte/local_vimrc',
    requires = 'LucHermitte/lh-vim-lib',
    config = function()
      vim.fn['lh#local_vimrc#filter_list']('asklist', [[v:val != $HOME]])
      vim.fn['lh#local_vimrc#munge']('sandboxlist', vim.fn.expand('$HOME'))
    end
  },

  -- A few functional programming utilities for VimL
  'dan-t/vim-fn',

  'xolox/vim-misc',

  'acustodioo/vim-tmux',
  {
    'voldikss/vim-floaterm',
    setup = function()
      vim.g.floaterm_rootmarkers = {'.git', '.gitignore'}
    end
  },
}

local version_control_plugins = {
  -- Show a sign in the gutter to signify changes
  {
    'mhinz/vim-signify',
    setup = function()
      vim.g.signify_realtime = 1
      vim.g.signify_vcs_list = {'git', 'hg'}
    end
  },

  -- Perform various git functions
  {'lambdalisue/gina.vim', cmd = 'Gina'},

  -- Open commit messages in a popup window
  {
    'rhysd/git-messenger.vim',
    cmd = 'GitMessenger'
  },

  {
    'samoshkin/vim-mergetool',
    setup = function()
      vim.g.mergetool_layout = 'LmR'
      vim.g.mergetool_prefer_revision = 'local'
    end
  },

  {
    'APZelos/blamer.nvim',
    setup = function ()
      vim.g.blamer_show_in_insert_modes = 0
      vim.g.blamer_show_in_visual_modes = 0
      vim.g.blamer_relative_time = 1
    end
  },

  'tyru/open-browser.vim',
  {
    'tyru/open-browser-github.vim',
    requires = 'tyru/open-browser.vim',
    setup = function()
      vim.g.openbrowser_github_always_used_branch = 1
    end
  }
}

local search_plugins = {
  'jremmen/vim-ripgrep',

  {
    'bronson/vim-visual-star-search',
    --[[
    [config = function ()
      [  vim.api.nvim_del_keymap('n', '<leader>*')
    [end
    ]]
  },  

  'Lokaltog/vim-easymotion',
  'brooth/far.vim'
}

local ui_plugins = {
  {
    'mhinz/vim-startify',
    setup = function ()
      vim.g.startify_session_dir = '~/.config/nvim/sessions'
      vim.g.startify_lists = {
        { type = 'files',     header =  {'   Files'}                                 },
        { type = 'dir',       header =  {'   Current Directory ' .. vim.fn.getcwd()} },
        { type = 'sessions',  header =  {'   Sessions'}                              },
        { type = 'bookmarks', header =  {'   Bookmarks'}                             },
      }
      vim.g.startify_bookmarks = { 
        { I = '~/dotfiles/vim/.vim/init.vim' },
        { K = '~/dotfiles/vim/.vim/autoload/makyo/keymap.json5' },
        { P = '~/dotfiles/vim/.vim/rc/dein.toml' },
        { Z = '~/dotfiles/zsh/.zshrc' },
        '~/Code'
      }
      vim.g.startify_session_persistence = 1
      vim.g.startify_change_to_vcs_root = 0
      vim.g.startify_session_sort = 1
      vim.g.startify_enable_special = 0
    end
  },

  {'Shougo/neomru.vim', disable = true},
  {'Shougo/denite.nvim', disable = true},

  {
    'junegunn/fzf',
    cond = function()
      local env = string.gsub(vim.fn.system('uname'), '\n', '')
      return env == 'Darwin'
    end
  }, 
  {
    'junegunn/fzf.vim',
    setup = function()
      vim.g.fzf_command_prefix = 'Fzf'
    end
  },

  {
    'jlanzarotta/bufexplorer',
    setup = function () 
      vim.g.bufExplorerDisableDefaultKeyMapping = 1
   end
  },

  {'wsdjeg/dein-ui.vim', disable = true},

  {
    'Yggdroot/indentLine',
    setup = function ()
      vim.g.indentLine_fileTypeExclude = {'text', 'help'}
      vim.g.indentLine_bufNameExclude = {'_.*', 'Startify*'}
      vim.g.indentLine_char = '┊'
    end
  },

  {
    'tomtom/quickfixsigns_vim',
    setup = function ()
      vim.g.quickfixsigns_classes = {'marks'}
    end
  },

  'psliwka/vim-smoothie',

  {'camspiers/lens.vim', requires = 'camspiers/animate.vim'},

  {
    't9md/vim-choosewin',
    setup = function ()
      vim.g.choosewin_overlay_enable = 1
    end
  },

  'TaDaa/vimade',

  {
    'vim-airline/vim-airline',
    config = function ()
      vim.g['airline#extensions#tabline#formatter'] = 'unique_tail_improved'

      vim.g.airline_powerline_fonts = 1
      vim.g.airline_highlighting_cache = 1
      vim.g.airline_exclude_preview = 1
      vim.g.airline_skip_empty_sections = 1

      vim.g.airline_mode_map = {
        ['__'] = '-',
        c      = 'C',
        i      = 'I',
        ic     = 'I',
        ix     = 'I',
        n      = 'N',
        multi  = 'M',
        ni     = 'N',
        no     = 'N',
        R      = 'R',
        Rv     = 'R',
        s      = 'S',
        S      = 'S',
        [''] = 'S',
        t      = 'T',
        v      = 'V',
        V      = 'V',
        [''] = 'V'
      }
    end
  },

  {
    'vim-airline/vim-airline-themes',
    config = function ()
      vim.g.airline_theme = 'minimalist'
      vim.g.airline_minimalist_showmod = 1
    end
  }
}

local themes = {
  'tomasr/molokai',
  'vim-scripts/fruity.vim',
  'altercation/vim-colors-solarized',
  'atelierbram/Base2Tone-vim',
  'ntk148v/vim-horizon',
  'yuttie/hydrangea-vim',
  'cseelus/vim-colors-lucid',
  'cseelus/vim-colors-tone',
  'flrnprz/candid.vim',
  'colepeters/spacemacs-theme.vim',
  'phanviet/vim-monokai-pro',
  'cideM/yui',
  'bruth/vim-newsprint-theme',
  'arzg/vim-colors-xcode',
  'vim-scripts/AfterColors.vim',

  {
    'rakr/vim-two-firewatch',
    setup = function ()
      vim.g.two_firewatch_italics = true
    end
  },

  {
    'ryanoasis/vim-devicons',
    config = function ()
      vim.g.airline_powerline_fonts=1
    end
  },

  -- Toolkit for developing new color schemes
  'lifepillar/vim-colortemplate'
}

-- See https://github.com/wbthomason/packer.nvim#bootstrapping
local function bootstrap()
  local execute = vim.api.nvim_command
  local fn = vim.fn

  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

  if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    execute 'packadd packer.nvim'
  end 
end

local function init()
  bootstrap()

  local packer = require 'packer'
  local use = packer.use 
  local use_rocks = packer.use_rocks

  packer.init()
  packer.reset()

  use_rocks 'tl'
  use_rocks 'compat53'
  use_rocks 'moses'

  use(general_purpose_plugins)
  use(language_plugins)
  use(coding_plugins)
  use(text_manipulation_plugins)
  use(application_plugins)
  use(version_control_plugins)
  use(search_plugins)
  use(ui_plugins)
  use(themes)
end

return { init = init }
