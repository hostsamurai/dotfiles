" Automatically generated packer.nvim plugin loader code

if !has('nvim')
  finish
endif

lua << END
local plugins = {
  ["acid.nvim"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/lou/.local/share/nvim/site/pack/packer/opt/acid.nvim"
  },
  ale = {
    loaded = false,
    only_sequence = true,
    only_setup = true,
    path = "/home/lou/.local/share/nvim/site/pack/packer/opt/ale"
  },
  ["blamer.nvim"] = {
    loaded = false,
    only_sequence = true,
    only_setup = true,
    path = "/home/lou/.local/share/nvim/site/pack/packer/opt/blamer.nvim"
  },
  ["coc.nvim"] = {
    loaded = false,
    only_sequence = true,
    only_setup = true,
    path = "/home/lou/.local/share/nvim/site/pack/packer/opt/coc.nvim"
  },
  conjure = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/lou/.local/share/nvim/site/pack/packer/opt/conjure"
  },
  ["editorconfig-vim"] = {
    loaded = false,
    only_sequence = true,
    only_setup = true,
    path = "/home/lou/.local/share/nvim/site/pack/packer/opt/editorconfig-vim"
  },
  ["gina.vim"] = {
    commands = { "Gina" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/lou/.local/share/nvim/site/pack/packer/opt/gina.vim"
  },
  ["git-messenger.vim"] = {
    commands = { "GitMessenger" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/lou/.local/share/nvim/site/pack/packer/opt/git-messenger.vim"
  },
  indentLine = {
    loaded = false,
    only_sequence = true,
    only_setup = true,
    path = "/home/lou/.local/share/nvim/site/pack/packer/opt/indentLine"
  },
  ["markdown-preview.nvim"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/lou/.local/share/nvim/site/pack/packer/opt/markdown-preview.nvim"
  },
  nerdcommenter = {
    loaded = false,
    only_sequence = true,
    only_setup = true,
    path = "/home/lou/.local/share/nvim/site/pack/packer/opt/nerdcommenter"
  },
  ["open-browser-github.vim"] = {
    loaded = false,
    only_sequence = true,
    only_setup = true,
    path = "/home/lou/.local/share/nvim/site/pack/packer/opt/open-browser-github.vim"
  },
  ["packer.nvim"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/lou/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  paredit = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/lou/.local/share/nvim/site/pack/packer/opt/paredit"
  },
  quickfixsigns_vim = {
    loaded = false,
    only_sequence = true,
    only_setup = true,
    path = "/home/lou/.local/share/nvim/site/pack/packer/opt/quickfixsigns_vim"
  },
  ["switch.vim"] = {
    commands = { "Switch" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/lou/.local/share/nvim/site/pack/packer/opt/switch.vim"
  },
  ["vim-choosewin"] = {
    loaded = false,
    only_sequence = true,
    only_setup = true,
    path = "/home/lou/.local/share/nvim/site/pack/packer/opt/vim-choosewin"
  },
  ["vim-dirvish"] = {
    loaded = false,
    only_sequence = true,
    only_setup = true,
    path = "/home/lou/.local/share/nvim/site/pack/packer/opt/vim-dirvish"
  },
  ["vim-fireplace"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/lou/.local/share/nvim/site/pack/packer/opt/vim-fireplace"
  },
  ["vim-floaterm"] = {
    loaded = false,
    only_sequence = true,
    only_setup = true,
    path = "/home/lou/.local/share/nvim/site/pack/packer/opt/vim-floaterm"
  },
  ["vim-hexokinase"] = {
    loaded = false,
    only_sequence = true,
    only_setup = true,
    path = "/home/lou/.local/share/nvim/site/pack/packer/opt/vim-hexokinase"
  },
  ["vim-mergetool"] = {
    loaded = false,
    only_sequence = true,
    only_setup = true,
    path = "/home/lou/.local/share/nvim/site/pack/packer/opt/vim-mergetool"
  },
  ["vim-niji"] = {
    loaded = false,
    only_sequence = true,
    only_setup = true,
    path = "/home/lou/.local/share/nvim/site/pack/packer/opt/vim-niji"
  },
  ["vim-node"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/lou/.local/share/nvim/site/pack/packer/opt/vim-node"
  },
  ["vim-nodejs-complete"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/lou/.local/share/nvim/site/pack/packer/opt/vim-nodejs-complete"
  },
  ["vim-prettier"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/lou/.local/share/nvim/site/pack/packer/opt/vim-prettier"
  },
  ["vim-rails"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/lou/.local/share/nvim/site/pack/packer/opt/vim-rails"
  },
  ["vim-redl"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/lou/.local/share/nvim/site/pack/packer/opt/vim-redl"
  },
  ["vim-signify"] = {
    loaded = false,
    only_sequence = true,
    only_setup = true,
    path = "/home/lou/.local/share/nvim/site/pack/packer/opt/vim-signify"
  },
  ["vim-startify"] = {
    loaded = false,
    only_sequence = true,
    only_setup = true,
    path = "/home/lou/.local/share/nvim/site/pack/packer/opt/vim-startify"
  },
  ["vim-two-firewatch"] = {
    loaded = false,
    only_sequence = true,
    only_setup = true,
    path = "/home/lou/.local/share/nvim/site/pack/packer/opt/vim-two-firewatch"
  }
}

local function handle_bufread(names)
  for _, name in ipairs(names) do
    local path = plugins[name].path
    for _, dir in ipairs({ 'ftdetect', 'ftplugin', 'after/ftdetect', 'after/ftplugin' }) do
      if #vim.fn.finddir(dir, path) > 0 then
        vim.cmd('doautocmd BufRead')
        return
      end
    end
  end
end

_packer_load = nil

local function handle_after(name, before)
  local plugin = plugins[name]
  plugin.load_after[before] = nil
  if next(plugin.load_after) == nil then
    _packer_load({name}, {})
  end
end

_packer_load = function(names, cause)
  local some_unloaded = false
  for _, name in ipairs(names) do
    if not plugins[name].loaded then
      some_unloaded = true
      break
    end
  end

  if not some_unloaded then return end

  local fmt = string.format
  local del_cmds = {}
  local del_maps = {}
  for _, name in ipairs(names) do
    if plugins[name].commands then
      for _, cmd in ipairs(plugins[name].commands) do
        del_cmds[cmd] = true
      end
    end

    if plugins[name].keys then
      for _, key in ipairs(plugins[name].keys) do
        del_maps[key] = true
      end
    end
  end

  for cmd, _ in pairs(del_cmds) do
    vim.cmd('silent! delcommand ' .. cmd)
  end

  for key, _ in pairs(del_maps) do
    vim.cmd(fmt('silent! %sunmap %s', key[1], key[2]))
  end

  for _, name in ipairs(names) do
    if not plugins[name].loaded then
      vim.cmd('packadd ' .. name)
      if plugins[name].config then
        for _i, config_line in ipairs(plugins[name].config) do
          loadstring(config_line)()
        end
      end

      if plugins[name].after then
        for _, after_name in ipairs(plugins[name].after) do
          handle_after(after_name, name)
          vim.cmd('redraw')
        end
      end

      plugins[name].loaded = true
    end
  end

  handle_bufread(names)

  if cause.cmd then
    local lines = cause.l1 == cause.l2 and '' or (cause.l1 .. ',' .. cause.l2)
    vim.cmd(fmt('%s%s%s %s', lines, cause.cmd, cause.bang, cause.args))
  elseif cause.keys then
    local keys = cause.keys
    local extra = ''
    while true do
      local c = vim.fn.getchar(0)
      if c == 0 then break end
      extra = extra .. vim.fn.nr2char(c)
    end

    if cause.prefix then
      local prefix = vim.v.count and vim.v.count or ''
      prefix = prefix .. '"' .. vim.v.register .. cause.prefix
      if vim.fn.mode('full') == 'no' then
        if vim.v.operator == 'c' then
          prefix = '' .. prefix
        end

        prefix = prefix .. vim.v.operator
      end

      vim.fn.feedkeys(prefix, 'n')
    end

    -- NOTE: I'm not sure if the below substitution is correct; it might correspond to the literal
    -- characters \<Plug> rather than the special <Plug> key.
    vim.fn.feedkeys(string.gsub(string.gsub(cause.keys, '^<Plug>', '\\<Plug>') .. extra, '<[cC][rR]>', '\r'))
  elseif cause.event then
    vim.cmd(fmt('doautocmd <nomodeline> %s', cause.event))
  elseif cause.ft then
    vim.cmd(fmt('doautocmd <nomodeline> %s FileType %s', 'filetypeplugin', cause.ft))
    vim.cmd(fmt('doautocmd <nomodeline> %s FileType %s', 'filetypeindent', cause.ft))
  end
end

-- Runtimepath customization

-- Pre-load configuration
-- Setup for: vim-mergetool
loadstring("\27LJ\1\2f\0\0\2\0\6\0\t4\0\0\0007\0\1\0%\1\3\0:\1\2\0004\0\0\0007\0\1\0%\1\5\0:\1\4\0G\0\1\0\nlocal\30mergetool_prefer_revision\bLmR\21mergetool_layout\6g\bvim\0")()
vim.cmd("packadd vim-mergetool")
-- Setup for: vim-floaterm
loadstring("\27LJ\1\2J\0\0\2\0\4\0\0054\0\0\0007\0\1\0003\1\3\0:\1\2\0G\0\1\0\1\3\0\0\t.git\15.gitignore\25floaterm_rootmarkers\6g\bvim\0")()
vim.cmd("packadd vim-floaterm")
-- Setup for: indentLine
loadstring("\27LJ\1\2ª\1\0\0\2\0\b\0\r4\0\0\0007\0\1\0003\1\3\0:\1\2\0004\0\0\0007\0\1\0003\1\5\0:\1\4\0004\0\0\0007\0\1\0%\1\a\0:\1\6\0G\0\1\0\bâ”Š\20indentLine_char\1\3\0\0\b_.*\14Startify*\30indentLine_bufNameExclude\1\3\0\0\ttext\thelp\31indentLine_fileTypeExclude\6g\bvim\0")()
vim.cmd("packadd indentLine")
-- Setup for: vim-niji
loadstring("\27LJ\1\2^\0\0\2\0\4\0\0054\0\0\0007\0\1\0003\1\3\0:\1\2\0G\0\1\0\1\6\0\0\tlisp\vscheme\fclojure\vfennel\njanet\28niji_matching_filetypes\6g\bvim\0")()
vim.cmd("packadd vim-niji")
-- Setup for: coc.nvim
loadstring("\27LJ\1\2_\0\0\2\0\6\0\t4\0\0\0007\0\1\0%\1\3\0:\1\2\0004\0\0\0007\0\1\0%\1\5\0:\1\4\0G\0\1\0\n<c-k>\21coc_snippet_prev\n<c-j>\21coc_snippet_next\6g\bvim\0")()
vim.cmd("packadd coc.nvim")
-- Setup for: switch.vim
loadstring("\27LJ\1\2:\0\0\2\0\4\0\0054\0\0\0007\0\1\0%\1\3\0:\1\2\0G\0\1\0\14<Space>tt\19switch_mapping\6g\bvim\0")()
-- Setup for: vim-hexokinase
loadstring("\27LJ\1\2ü\2\0\0\3\0\14\0!4\0\0\0007\0\1\0003\1\3\0:\1\2\0004\0\0\0007\0\1\0003\1\5\0004\2\0\0007\2\1\0027\2\2\2:\2\6\0014\2\0\0007\2\1\0027\2\2\2:\2\a\0014\2\0\0007\2\1\0027\2\2\2:\2\b\0014\2\0\0007\2\1\0027\2\2\2:\2\t\1:\1\4\0004\0\0\0007\0\1\0003\1\v\0:\1\n\0004\0\0\0007\0\1\0003\1\r\0:\1\f\0G\0\1\0\1\2\0\0\thelp\26Hexokinase_ftDisabled\1\6\0\0\bcss\tless\tsass\tscss\fclojure\25Hexokinase_ftEnabled\tsass\tscss\tless\bcss\1\0\1\fclojure!full_hex,triple_hex,hsl,hsla\31Hexokinase_ftOptInPatterns\1\a\0\0\rfull_hex\15triple_hex\brgb\trgba\bhsl\thsla\28all_hexokinase_patterns\6g\bvim\0")()
vim.cmd("packadd vim-hexokinase")
-- Setup for: vim-startify
loadstring("\27LJ\1\2ì\5\0\0\6\0\26\0<4\0\0\0007\0\1\0%\1\3\0:\1\2\0004\0\0\0007\0\1\0002\1\5\0003\2\5\0003\3\6\0:\3\a\2;\2\1\0013\2\b\0002\3\3\0%\4\t\0004\5\0\0007\5\n\0057\5\v\5>\5\1\2$\4\5\4;\4\1\3:\3\a\2;\2\2\0013\2\f\0003\3\r\0:\3\a\2;\2\3\0013\2\14\0003\3\15\0:\3\a\2;\2\4\1:\1\4\0004\0\0\0007\0\1\0003\1\21\0003\2\17\0;\2\1\0013\2\18\0;\2\2\0013\2\19\0;\2\3\0013\2\20\0;\2\4\1:\1\16\0004\0\0\0007\0\1\0'\1\1\0:\1\22\0004\0\0\0007\0\1\0'\1\0\0:\1\23\0004\0\0\0007\0\1\0'\1\1\0:\1\24\0004\0\0\0007\0\1\0'\1\0\0:\1\25\0G\0\1\0\28startify_enable_special\26startify_session_sort startify_change_to_vcs_root!startify_session_persistence\1\6\0\0\0\0\0\0\v~/Code\1\0\1\6Z\26~/dotfiles/zsh/.zshrc\1\0\1\6P%~/dotfiles/vim/.vim/rc/dein.toml\1\0\1\6K4~/dotfiles/vim/.vim/autoload/makyo/keymap.json5\1\0\1\6I!~/dotfiles/vim/.vim/init.vim\23startify_bookmarks\1\2\0\0\17   Bookmarks\1\0\1\ttype\14bookmarks\1\2\0\0\16   Sessions\1\0\1\ttype\rsessions\vgetcwd\afn\26   Current Directory \1\0\1\ttype\bdir\vheader\1\2\0\0\r   Files\1\0\1\ttype\nfiles\19startify_lists\28~/.config/nvim/sessions\25startify_session_dir\6g\bvim\0")()
vim.cmd("packadd vim-startify")
-- Setup for: ale
loadstring("\27LJ\1\2ó\1\0\0\3\0\n\0\0234\0\0\0007\0\1\0'\1\1\0:\1\2\0004\0\0\0007\0\1\0'\1\1\0:\1\3\0004\0\0\0007\0\1\0'\1\1\0:\1\4\0004\0\0\0007\0\1\0'\1\1\0:\1\5\0004\0\0\0007\0\1\0003\1\b\0003\2\a\0:\2\t\1:\1\6\0G\0\1\0\6*\1\0\0\1\3\0\0\26remove_trailing_lines\20trim_whitespace\15ale_fixers\20ale_fix_on_save\21ale_set_balloons\20ale_disable_lsp#airline#extensions#ale#enabled\6g\bvim\0")()
vim.cmd("packadd ale")
-- Setup for: open-browser-github.vim
loadstring("\27LJ\1\2G\0\0\2\0\3\0\0054\0\0\0007\0\1\0'\1\1\0:\1\2\0G\0\1\0*openbrowser_github_always_used_branch\6g\bvim\0")()
vim.cmd("packadd open-browser-github.vim")
-- Setup for: vim-dirvish
loadstring("\27LJ\1\2>\0\0\2\0\4\0\0054\0\0\0007\0\1\0%\1\3\0:\1\2\0G\0\1\0\20:sort ,^.*[\\/],\17dirvish_mode\6g\bvim\0")()
vim.cmd("packadd vim-dirvish")
-- Setup for: nerdcommenter
loadstring("\27LJ\1\2[\0\0\2\0\4\0\t4\0\0\0007\0\1\0'\1\0\0:\1\2\0004\0\0\0007\0\1\0'\1\1\0:\1\3\0G\0\1\0\31NERDTrimTrailingWhitespace\19NERDSpaceDelim\6g\bvim\0")()
vim.cmd("packadd nerdcommenter")
-- Setup for: paredit
loadstring("\27LJ\1\2“\1\0\0\2\0\a\0\0174\0\0\0007\0\1\0'\1\1\0:\1\2\0004\0\0\0007\0\1\0'\1\1\0:\1\3\0004\0\0\0007\0\1\0'\1\1\0:\1\4\0004\0\0\0007\0\1\0%\1\6\0:\1\5\0G\0\1\0\6,\19paredit_leader\22paredit_smartjump\22paredit_shortmaps\17paredit_mode\6g\bvim\0")()
-- Setup for: blamer.nvim
loadstring("\27LJ\1\2Ž\1\0\0\2\0\5\0\r4\0\0\0007\0\1\0'\1\0\0:\1\2\0004\0\0\0007\0\1\0'\1\0\0:\1\3\0004\0\0\0007\0\1\0'\1\1\0:\1\4\0G\0\1\0\25blamer_relative_time blamer_show_in_visual_modes blamer_show_in_insert_modes\6g\bvim\0")()
vim.cmd("packadd blamer.nvim")
-- Setup for: conjure
loadstring("\27LJ\1\2^\0\0\2\0\4\0\0054\0\0\0007\0\1\0%\1\3\0:\1\2\0G\0\1\0\raniseed.8conjure#client#fennel#aniseed#aniseed_module_prefix\6g\bvim\0")()
-- Setup for: vim-two-firewatch
loadstring("\27LJ\1\0027\0\0\2\0\3\0\0054\0\0\0007\0\1\0)\1\2\0:\1\2\0G\0\1\0\26two_firewatch_italics\6g\bvim\0")()
vim.cmd("packadd vim-two-firewatch")
-- Setup for: vim-choosewin
loadstring("\27LJ\1\2:\0\0\2\0\3\0\0054\0\0\0007\0\1\0'\1\1\0:\1\2\0G\0\1\0\29choosewin_overlay_enable\6g\bvim\0")()
vim.cmd("packadd vim-choosewin")
-- Setup for: quickfixsigns_vim
loadstring("\27LJ\1\2A\0\0\2\0\4\0\0054\0\0\0007\0\1\0003\1\3\0:\1\2\0G\0\1\0\1\2\0\0\nmarks\26quickfixsigns_classes\6g\bvim\0")()
vim.cmd("packadd quickfixsigns_vim")
-- Setup for: vim-signify
loadstring("\27LJ\1\2^\0\0\2\0\5\0\t4\0\0\0007\0\1\0'\1\1\0:\1\2\0004\0\0\0007\0\1\0003\1\4\0:\1\3\0G\0\1\0\1\3\0\0\bgit\ahg\21signify_vcs_list\21signify_realtime\6g\bvim\0")()
vim.cmd("packadd vim-signify")
-- Setup for: editorconfig-vim
loadstring('\27LJ\1\2‰\1\0\0\2\0\6\0\t4\0\0\0007\0\1\0003\1\3\0:\1\2\0004\0\0\0007\0\1\0%\1\5\0:\1\4\0G\0\1\0\21external_command\27EditorConfig_core_mode\1\2\0\0\18fugitive://.*"EditorConfig_exclude_patterns\6g\bvim\0')()
vim.cmd("packadd editorconfig-vim")
-- Post-load configuration
-- Config for: local_vimrc
loadstring("\27LJ\1\2²\1\0\0\4\0\t\0\0174\0\0\0007\0\1\0007\0\2\0%\1\3\0%\2\4\0>\0\3\0014\0\0\0007\0\1\0007\0\5\0%\1\6\0004\2\0\0007\2\1\0027\2\a\2%\3\b\0>\2\2\0=\0\1\1G\0\1\0\n$HOME\vexpand\16sandboxlist\25lh#local_vimrc#munge\19v:val != $HOME\fasklist\31lh#local_vimrc#filter_list\afn\bvim\0")()
-- Config for: vim-airline
loadstring("\27LJ\1\2ø\2\0\0\2\0\n\0\0254\0\0\0007\0\1\0%\1\3\0:\1\2\0004\0\0\0007\0\1\0'\1\1\0:\1\4\0004\0\0\0007\0\1\0'\1\1\0:\1\5\0004\0\0\0007\0\1\0'\1\1\0:\1\6\0004\0\0\0007\0\1\0'\1\1\0:\1\a\0004\0\0\0007\0\1\0003\1\t\0:\1\b\0G\0\1\0\1\0\18\6S\6S\6R\6R\6V\6V\ano\6N\ani\6N\6n\6N\6\19\6S\6t\6T\6\22\6V\aRv\6R\6s\6S\nmulti\6M\a__\6-\6c\6C\6v\6V\aix\6I\aic\6I\6i\6I\21airline_mode_map airline_skip_empty_sections\28airline_exclude_preview\31airline_highlighting_cache\28airline_powerline_fonts\25unique_tail_improved)airline#extensions#tabline#formatter\6g\bvim\0")()
-- Config for: vim-better-default
loadstring("\27LJ\1\2s\0\0\2\0\4\0\t4\0\0\0007\0\1\0'\1\0\0:\1\2\0004\0\0\0007\0\1\0'\1\1\0:\1\3\0G\0\1\0'vim_better_default_persistent_undo#vim_better_default_key_mapping\6g\bvim\0")()
-- Config for: vim-devicons
loadstring("\27LJ\1\0029\0\0\2\0\3\0\0054\0\0\0007\0\1\0'\1\1\0:\1\2\0G\0\1\0\28airline_powerline_fonts\6g\bvim\0")()
-- Config for: vim-airline-themes
loadstring("\27LJ\1\2e\0\0\2\0\5\0\t4\0\0\0007\0\1\0%\1\3\0:\1\2\0004\0\0\0007\0\1\0'\1\1\0:\1\4\0G\0\1\0\31airline_minimalist_showmod\15minimalist\18airline_theme\6g\bvim\0")()
-- Config for: vim-which-key
loadstring("\27LJ\1\2i\0\0\2\0\4\0\t4\0\0\0007\0\1\0'\1\1\0:\1\2\0004\0\0\0007\0\1\0'\1\1\0:\1\3\0G\0\1\0\31which_key_use_floating_win!which_key_align_by_separator\6g\bvim\0")()
-- Config for: vim-polyglot
loadstring("\27LJ\1\2š\1\0\0\2\0\6\0\r4\0\0\0007\0\1\0'\1\1\0:\1\2\0004\0\0\0007\0\1\0003\1\4\0:\1\3\0004\0\0\0007\0\1\0'\1\0\0:\1\5\0G\0\1\0$clojure_align_multiline_strings\1\4\0\0\bdom\bmoz\nes6th\19jscomplete_use\28javascript_plugin_jsdoc\6g\bvim\0")()
-- Conditional loads
-- Load plugins in order defined by `after`
END

function! s:load(names, cause) abort
call luaeval('_packer_load(_A[1], _A[2])', [a:names, a:cause])
endfunction


" Command lazy-loads
command! -nargs=* -range -bang -complete=file Gina call s:load(['gina.vim'], { "cmd": "Gina", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file GitMessenger call s:load(['git-messenger.vim'], { "cmd": "GitMessenger", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file Switch call s:load(['switch.vim'], { "cmd": "Switch", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })

" Keymap lazy-loads

augroup packer_load_aucmds
  au!
  " Filetype lazy-loads
  au FileType html ++once call s:load(['vim-prettier'], { "ft": "html" })
  au FileType typescript ++once call s:load(['vim-prettier'], { "ft": "typescript" })
  au FileType fennel ++once call s:load(['paredit', 'conjure'], { "ft": "fennel" })
  au FileType chicken ++once call s:load(['paredit', 'conjure'], { "ft": "chicken" })
  au FileType ruby ++once call s:load(['vim-rails'], { "ft": "ruby" })
  au FileType less ++once call s:load(['vim-prettier'], { "ft": "less" })
  au FileType javascript ++once call s:load(['vim-nodejs-complete', 'vim-prettier', 'vim-node'], { "ft": "javascript" })
  au FileType scss ++once call s:load(['vim-prettier'], { "ft": "scss" })
  au FileType yaml ++once call s:load(['vim-prettier'], { "ft": "yaml" })
  au FileType json ++once call s:load(['vim-prettier'], { "ft": "json" })
  au FileType markdown ++once call s:load(['vim-prettier', 'markdown-preview.nvim'], { "ft": "markdown" })
  au FileType pandoc.markdown ++once call s:load(['markdown-preview.nvim'], { "ft": "pandoc.markdown" })
  au FileType css ++once call s:load(['vim-prettier'], { "ft": "css" })
  au FileType clojure ++once call s:load(['vim-fireplace', 'paredit', 'acid.nvim', 'vim-redl', 'conjure'], { "ft": "clojure" })
  au FileType graphql ++once call s:load(['vim-prettier'], { "ft": "graphql" })
  au FileType scheme ++once call s:load(['paredit', 'conjure'], { "ft": "scheme" })
  au FileType rmd ++once call s:load(['markdown-preview.nvim'], { "ft": "rmd" })
  au FileType racket ++once call s:load(['paredit', 'conjure'], { "ft": "racket" })
  " Event lazy-loads
augroup END
