" Plugin stuff {{{
call plug#begin('~/.vim/plugged')

" Utility
Plug 'vim-ctrlspace/vim-ctrlspace'
Plug 'rking/ag.vim'
Plug 'gregsexton/VimCalc'
Plug 'vim-scripts/visincr'
Plug 'jlanzarotta/bufexplorer'
Plug 'editorconfig/editorconfig-vim'
Plug 'sjl/gundo.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/syntastic'
Plug 'godlygeek/tabular'
Plug 'majutsushi/tagbar'
Plug 'Townk/vim-autoclose'
Plug 'Lokaltog/vim-easymotion'
Plug 'tpope/vim-classpath'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-multiple-cursors'
Plug 'acustodioo/vim-tmux'
Plug 'bronson/vim-visual-star-search'

" Snippets
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" Language
Plug 'othree/html5.vim'
Plug 'mattn/emmet-vim'
Plug 'mustache/vim-mustache-handlebars'
Plug 'tpope/vim-haml'

Plug 'plasticboy/vim-markdown'
Plug 'timcharper/textile.vim'

Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
Plug 'tpope/vim-fireplace',     { 'for': 'clojure' }
Plug 'dgrnbrg/vim-redl',        { 'for': 'clojure' }

Plug 'OrangeT/vim-csharp'

Plug 'ap/vim-css-color',       { 'for': ['css', 'sass', 'scss'] }
Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'sass', 'scss'] }

Plug 'alunny/pegjs-vim'
Plug 'guileen/vim-node'
Plug 'myhere/vim-nodejs-complete'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

Plug 'vim-ruby/vim-ruby'
Plug 'hallison/vim-ruby-sinatra'
Plug 'tpope/vim-rails'

Plug 'mutewinter/nginx.vim'
Plug 'kurayama/systemd-vim-syntax'

" Themes
Plug 'tomasr/molokai'
Plug 'vim-scripts/fruity.vim'
Plug 'altercation/vim-colors-solarized'


call plug#end()

runtime macros/matchit.vim
" }}}


" Basic options {{{
" -----------------------------------------------------------------------------
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set backup		    " keep a backup file
set backupdir=~/.vim/backups
set directory=~/.vim/tmp
set history=10000 " keep 20000 lines of command line history
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set showmatch
set hlsearch
set nocompatible
set hidden

" Don't use Ex mode, use Q for formatting
noremap Q gq

" CTRL-U in insert mode deletes a lot. Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

augroup vimrcEx
  au!
  autocmd FileType text setlocal textwidth=78
augroup END


" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" set console colorscheme
set t_Co=256
let g:solarized_termcolors=256
colorscheme solarized
set bg=dark
if has('gui_running')
  set guioptions-=T " no toolbar
  set guioptions-=r " no right scrollbar
  set guioptions-=L " no left scrollbar
  set guioptions-=l " no left scrollbar
endif
" }}}


" Usability options {{{
" -----------------------------------------------------------------------------
set encoding=utf-8
set ttyfast
set ruler " show cursor position
set showcmd " show partial commands
set lazyredraw
set matchtime=3
set autowrite
set autoread
set shiftround
set linebreak
set ignorecase smartcase " case insensitive search
set hidden
set laststatus=2
set cmdheight=2
set number
set sessionoptions=resize,winpos,winsize,buffers,tabpages,folds,curdir,localoptions,help
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" hide the tabline - rely on ctrlspace for navigation instead
set showtabline=0

set expandtab " turn tabs into spaces
set formatoptions=tcqrn

" Don't attempt to highlight lines longer than 800 characters
set synmaxcol=800

set foldlevelstart=99

" Better completion
set complete=.,w,b,u,t
set completeopt=longest,menuone,preview

set grepprg=ag " Use Silver Searcher instead of grep

" save on losing focus when moving away from tab
au FocusLost * :wa

" resize splits when the window is resized
au VimResized * :wincmd =

" Cursorline {{{
" Only show the cursorline in the current window and in normal mode
augroup cline
  au!
  au WinLeave,InsertEnter * set nocursorline
  au WinEnter,InsertLeave * set cursorline
augroup END
" }}}

" Wildmenu completion {{{
set wildmenu
set wildmode=list:longest,full
set wildignore+=.hg,.git,.svn " version control
set wildignore+=*.jpg,*.gif,*.png,*.jpeg " binary images
" Clojure/Leiningen
set wildignore+=classes
set wildignore+=lib
" }}}

" Make sure vim returns to the same line when you reopen a file.
augroup line_return
    au!
    au BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\   execute 'normal! g`"zvzz' |
	\ endif
augroup END
" }}}


" Convenience Mappings {{{
" -----------------------------------------------------------------------------
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" easier window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" heretical mappings for command-line mode
cnoremap <C-A> <Home>
" back one character
cnoremap <C-B> <Left>
" delete character under cursor
cnoremap <C-D> <Del>
" end of line
cnoremap <C-E> <End>
" forward one character
cnoremap <C-F> <Right>
" recall newer command-line
cnoremap <C-N> <Down>
" recall previous (older) command-line
cnoremap <C-P> <Up>

" easier tab creation
nnoremap tc :tabnew<CR>

" moving around tabs
nnoremap <Leader>( :tabprev<cr>
nnoremap <Leader>) :tabnext<cr>

" Delete text after the cusor position in insert mode.
" Useful for deleting superflous quote marks left by auto-closing plugins.
inoremap <C-d> <C-[>ld$A

" toggle folds
noremap <Space> zA

" use sane regexes
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v
nnoremap s/ s/\v
cnoremap s/ s/\v
vnoremap s/ s/\v
cnoremap %s/ %s/\v
vnoremap %s/ %s/\v

" clear search highlights
noremap <silent> <Leader>/ :nohls<CR>

" delete the current line w/ '-'
nnoremap - dd

" escape from insert mode w/out stretching your fingers
inoremap jk <esc>

" make Y behave like other capitals
nnoremap Y y$

" search for word under the cursor
noremap <Leader>g :exe "Ag! -R " . shellescape(expand("<cWORD>")) . " ."<cr>

" using sudo to write a file
cnoremap w!! w !sudo tee % >/dev/null

" edit and source vimrc easier
nnoremap <Leader>ev :tabnew $MYVIMRC<CR>
nnoremap <Leader>sv :so $MYVIMRC<CR>
" }}}


" Plugin-specific options {{{
" -----------------------------------------------------------------------------
" nerdtree settings
nnoremap <Leader>t :NERDTreeToggle<CR>

let g:gundo_prefer_python3 = 1

" ctrlspace settings
let g:CtrlSpaceSaveWorkspaceOnSwitch = 1
let g:CtrlSpaceSaveWorkspaceOnExit = 1

if executable("ag")
  let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
endif

nnoremap <silent><C-p> :CtrlSpace 0<CR>

" ultisnips settings
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsEditSplit = "horizontal"
let g:UltiSnipsSnippetDirectories = ['UltiSnips', 'custom_snippets']

let g:jscomplete_use = ['dom', 'moz', 'es6th']

" vim-session settings
let g:session_autosave = 'yes'
let g:session_autoload = 'no'

" Tag options
set tags=./tags;${HOME}
nmap <Leader>rt :TagbarToggle<CR>

let g:tagbar_type_css = {
\ 'ctagstype': 'css',
\ 'kinds': [
\   'c:classes',
\   'i:ids',
\   't:tags',
\   'm:medias'
\ ]
\}

let g:tagbar_type_scss = {
\ 'ctagstype': 'scss',
\ 'kinds': [
\   'm:mixins',
\   'v:variables',
\   'c:classes',
\   'i:ids',
\   't:tags',
\   'd:medias'
\ ]
\}

let g:EditorConfig_exclude_patterns = ['fugitive://.*']
let g:EditorConfig_core_mode = 'external_command'

let g:syntastic_javascript_checkers = ['eslint']
let g:javascript_plugin_jsdoc = 1
" }}}


" Utility functions {{{
" -----------------------------------------------------------------------------
" Upgrade vim-plug after updating all plugins
command! PU PlugUpdate | PlugUpgrade

function! Preserve(command)
  " Preparation: save last search and cursor position
  let _s = @/
  let l = line('.')
  let c = col('.')
  " Do the business:
  execute a:command
  " Clean up: restore previous cursor position and search history
  let @/=_s
  call cursor(l,c)
endfunction

" strip trailing whitespace before saving a file
autocmd BufWritePre * :call Preserve('%s/\v\s+$//e')

" quick and dirty way to create a scratch buffer
function! Scratch()
  execute "tabnew scratch | setlocal buftype=nofile bufhidden=hide noswapfile"
endfunction

command! Scratch :call Scratch()

" temporary fix tab spacing in a buffer
function! TabToggle()
  setlocal ci pi sts=0 sw=4 ts=4
endfunction

command! TabToggle :call TabToggle()

" preview link in browser
function! HandleURI()
  let s:uri = matchstr(getline("."), "[a-z]*:\/\/[^ >,;:]*")
  echo s:uri
  if s:uri != ""
    exec "!firefox \"" . s:uri . "\""
    else
    echo "No URI found in line"
  endif
endfunction

command! HandleURI :call HandleURI()
" }}}


" Custom mappings {{{
" -----------------------------------------------------------------------------

" run a silver searcher query in a new tab
nnoremap <Leader>ag :tabnew<CR>:Ag -i<Space>'

" run a silver searcher query in a new tab using the word under the cursor
nnoremap <Leader>Ag yaw:tabnew<CR>:Ag -i '<C-R>"'<Space>


" Filetype-specific options {{{
" -----------------------------------------------------------------------------
" ruby settings
augroup ft_ruby
  au!
  au Filetype ruby,eruby,yaml,erb,ru set sw=2 sts=2 et smarttab smartindent
  au Filetype ruby,eruby,yaml,erb,ru set omnifunc=rubycomplete#Complete completeopt=menu,preview
  au Filetype ruby,eruby,yaml,erb,ru set foldmethod=syntax
  au Filetype ruby,eruby,yaml,erb,ru let g:rubycomplete_buffer_loading=1
  au Filetype ruby,eruby,yaml,erb,ru let g:rubycomplete_classes_in_global=1
  au Filetype ruby,eruby,yaml,erb,ru let g:rubycomplete_rails=1
  au BufRead,BufNewFile Thorfile set ft=ruby
augroup END


" html settings
augroup ft_html
  au!
  au Filetype html,xhtml set sw=2 sts=2 et smarttab smartindent
  au Filetype html,xhtml set omnifunc=htmlcomplete#CompleteTags
augroup END


" javascript settings
augroup ft_javascript
  au!
  au Filetype javascript,json set sw=2 sts=2 et smarttab smartindent
  au Filetype javascript,json set foldmethod=syntax
  au Filetype javascript,json set omnifunc=jscomplete#CompleteJS

  au Filetype json set formatoptions=tcq2l
augroup END


" coffeescript settings
augroup ft_coffeescript
  au!
  au BufWritePost *.coffee silent CoffeeMake! | cwindow
  let coffee_folding = 1
  let coffee_no_trailing_space_error = 1
augroup END


" haml/sass/scss/css settings
augroup ft_css_preprocessors
  au!
  au Filetype sass,scss,less,css set sw=2 sts=2 et smarttab smartindent
  au Filetype sass,scss,less,css set foldmethod=indent
  au Filetype sass,scss,less,css set omnifunc=csscomplete#CompleteCSS
augroup END


" clojure settings
augroup ft_clojure
  au!
  let g:clojure_align_multiline_strings = 0
  let tlist_clojure_settings='lisp;f:function'
augroup END


" markdown settings
augroup ft_mkd
  au!
  au Filetype md,mkd,markdown set tw=80
augroup END


" viml settings
augroup ft_viml
    au!
    au Filetype vim set sw=2 sts=2 ts=2 et smarttab smartindent
    au Filetype vim setlocal foldmethod=marker et
augroup END


" svn settings
augroup ft_svn
  au!
  au Filetype svn setlocal tw=72
augroup END
" }}}
"
