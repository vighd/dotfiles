" ------------------------------------ PLUGIN MANAGEMENT ------------------------------------ "

let plug=expand($HOME.'/.vim/autoload/plug.vim')
if !filereadable(plug)
  echo "Installing Plugin manager.."
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.vim/plugins')
  Plug 'sheerun/vim-polyglot'
  Plug 'drewtempelmeyer/palenight.vim'
  Plug 'itchyny/lightline.vim'
  Plug 'Raimondi/delimitMate'
  Plug 'dense-analysis/ale'
  Plug 'fatih/vim-go'
  Plug 'mhinz/vim-signify'
  Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'vim-scripts/colorizer'
  Plug 'heavenshell/vim-jsdoc', {
  \ 'for': ['javascript', 'typescript'],
  \ 'do': 'make install'
  \}
  Plug 'alvan/vim-closetag'
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
  Plug 'vifm/vifm.vim'
  Plug 'vighd/vim-pgsql-query'
call plug#end()

" ------------------------------------- PLUGIN CONFIGS --------------------------------------- "

" Lightline
let g:lightline = { 
  \ 'colorscheme': 'palenight',
  \ 'component': {
  \   'filename': '%F',
  \ }
\}

" Vim-GO
let g:go_gocode_unimported_packages = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_fmt_autosave = 0
let g:go_auto_type_info = 1

" ALE
" Installable packages - ruby-sqlint pgformatter-git prettier go shfmt
let g:ale_lint_delay = 800
let g:ale_javascript_prettier_options = '--jsx-single-quote --single-quote --tab-width 2 --no-semi --print-width 100'
let g:ale_fixers = {
\ 'css': ['prettier'],
\ 'typescript': ['prettier'],
\ 'javascript': ['prettier'],
\ 'go': ['gofmt', 'goimports'],
\ 'sh': ['shfmt'],
\ 'sql': ['pgformatter'],
\}

" Closetag
let g:closetag_filenames = '*.html,*.js'

" DelimitMate
let g:delimitMate_balance_matchpairs = 1

" Polyglot
let g:sql_type_default = 'pgsql'
let g:pgsql_pl = ['javascript']

" ---------------------------------------- VIM CONFIG ----------------------------------------- "

set mouse=c
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
set autoindent
set background=dark
set termguicolors
set laststatus=2
colorscheme palenight
set magic
set showmatch
set smartcase
set nohlsearch
set hlsearch
set incsearch
set nobackup
set path=**
set wildmode=longest:full,list:full
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,.svn,*.gem,*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.swp,*~,._*,*/node_modules/*,*/data/*,*/.git/*,*/dist/*,*/build/*
set wildmenu
set wildchar=9
set number
set equalalways
set autoread
set encoding=utf-8
set nocompatible
set updatetime=100
set splitbelow
set completeopt=menu,menuone,popup,noselect,noinsert
set omnifunc=ale#completion#OmniFunc
set noswapfile
syntax enable

" ---------------------------------------- KEY MAPPINGS --------------------------------------- "

" Format code with F4
nmap <silent> <F4> :ALEFix<CR>
" Clear search highlighting
nnoremap <silent> <C-l> :nohlsearch<CR> :syntax sync fromstart<CR><C-l>
" Run macro in visual mode with .
xnoremap . :normal @q<CR>
" Remap file finder base on the buffer name
nnoremap <expr> ff bufname("%") == "" ? ':find ' : ':tabfind '
" Git blame
nnoremap gb :echomsg system("git blame -L ".line(".").",".line(".")." ".expand("%"))[:-2]<CR>
" Remap TAB to change tab o.O
noremap <TAB> gt
noremap <S-TAB> gT
" ALE rename with rn
nnoremap rn :ALERename<CR>
" ALE go to definiton with gd
nnoremap gd :ALEGoToDefinition<CR>
" ALE go to type definiton with gtd
nnoremap gtd :ALEGoToTypeDefinition<CR>
" ALE go references
nnoremap gr :ALEFindReferences -tab<CR>
" JSDOC with <F6>
nmap <silent> <F6> <Plug>(jsdoc)
" PGSQLQuery
nnoremap <F9> :call RunPGSQLQuery()<CR>
xnoremap <F9> :call RunPGSQLVisualQuery()<CR>
xnoremap <S-F9> :call RunPGSQLQueryToCsv()<CR>
" <F3> Open Vifm
nnoremap <expr> <F3> bufname("%") == "" ? ':Vifm<CR>' : ':TabVifm<CR>'
" Markdown Preview
nmap <C-p> <Plug>MarkdownPreviewToggle

" ------------------------------------- AUTOCOMMANDS ------------------------------------- "

" Fix styled components syntax hl at start
au BufEnter * :syntax sync fromstart
" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
