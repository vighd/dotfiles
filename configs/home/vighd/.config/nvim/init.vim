" ------------------------------------ PLUGIN MANAGEMENT ------------------------------------ "

let plug=expand(stdpath('data') . '/site/autoload/plug.vim')
if !filereadable(plug)
  echo "Installing Plugin manager.."
  silent !sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin(stdpath('data') . '/plugged')
  Plug 'sheerun/vim-polyglot'
  Plug 'drewtempelmeyer/palenight.vim'
  Plug 'itchyny/lightline.vim'
  Plug 'Raimondi/delimitMate'
  Plug 'mhinz/vim-signify'
  Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'vim-scripts/colorizer'
  Plug 'heavenshell/vim-jsdoc', {
  \ 'for': ['javascript', 'typescript'],
  \ 'do': 'make install'
  \}
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'fatih/vim-go'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
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
" disable all linters as that is taken care of by coc.nvim
let g:go_diagnostics_enabled = 0
let g:go_metalinter_enabled = []

" don't jump to errors after metalinter is invoked
let g:go_jump_to_error = 0

" run go imports on file save
let g:go_fmt_command = "goimports"

" automatically highlight variable your cursor is on
let g:go_auto_sameids = 0

" Go Syntax
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1

" DelimitMate
let g:delimitMate_balance_matchpairs = 1

" Polyglot
let g:sql_type_default = 'pgsql'
let g:pgsql_pl = ['javascript']

" Coc
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-prettier',
  \ 'coc-sh',
  \ 'coc-go',
  \ 'coc-dictionary',
  \ 'coc-syntax',
  \ 'coc-eslint'
\]

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
set path=**
set wildmode=longest:full,list:full
set wildignore+=*/node_modules/*,*/data/*,*/.git/*,*/dist/*,*/build/*
set wildmenu
set wildchar=9
set number
set equalalways
set autoread
set encoding=utf-8
"set nocompatible
set updatetime=300
set splitbelow
"set completeopt=menu,menuone,popup,noselect,noinsert
set noswapfile
set relativenumber
set lazyredraw
set shortmess+=c
set signcolumn=yes
set hidden
set nobackup
set nowritebackup
syntax enable

" ---------------------------------------- KEY MAPPINGS --------------------------------------- "

" Clear search highlighting
nnoremap <silent> <C-l> :nohlsearch<CR> :syntax sync fromstart<CR><C-l>
" Run macro in visual mode with .
xnoremap . :normal @q<CR>
" Git blame
nnoremap gb :echomsg system("git blame -L ".line(".").",".line(".")." ".expand("%"))[:-2]<CR>
" Remap TAB to change tab o.O
noremap <TAB> gt
noremap <S-TAB> gT
" JSDOC with <F6>
nmap <silent> <F6> <Plug>(jsdoc)
" Window resize
nnoremap <silent> <S-Right> :vertical resize +5<CR>
nnoremap <silent> <S-Left> :vertical resize -5<CR>
nnoremap <silent> <S-Up> :resize +5<CR>
nnoremap <silent> <S-Down> :resize -5<CR>
" Coc
nmap <silent> gd :call CocAction('jumpDefinition', 'tab drop')<CR>
nmap <silent> gtd <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> rn <Plug>(coc-rename)
nmap <F4> :call CocAction('format')<CR>
nnoremap <silent> K :call CocAction('doHover')<CR>
" Fast movement
nnoremap <C-j> 5jzz
nnoremap <C-k> 5kzz
" Find files using Telescope command-line sugar.
nnoremap ff <cmd>Telescope find_files<cr>
nnoremap fg <cmd>Telescope live_grep<cr>

" ------------------------------------- AUTOCOMMANDS ------------------------------------- "

" Fix styled components syntax hl at start
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
