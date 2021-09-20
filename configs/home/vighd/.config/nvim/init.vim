" ------------------------------------- PLUGIN MANAGEMENT ------------------------------------- "

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
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'tpope/vim-dadbod'
  Plug 'kristijanhusak/vim-dadbod-ui'
  Plug 'vifm/vifm.vim'
  Plug 'Jorengarenar/vim-SQL-UPPER'
  Plug 'lifepillar/pgsql.vim'
  Plug 'heavenshell/vim-jsdoc', {
    \ 'for': ['javascript', 'javascript.jsx','typescript'],
    \ 'do': 'make install'
  \}
  Plug 'styled-components/vim-styled-components'
call plug#end()

" ------------------------------------- PLUGIN CONFIGS ---------------------------------------- "

" Set leader key
let mapleader = ","

" Lightline
let g:lightline = {
  \ 'colorscheme': 'palenight',
  \ 'component': {
  \   'filename': '%F',
  \ }
\}

" Coc
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-prettier',
  \ 'coc-sh',
  \ 'coc-db',
  \ 'coc-go',
  \ 'coc-dictionary',
  \ 'coc-eslint',
  \ 'coc-git',
  \ 'coc-lists',
  \ 'coc-diagnostic',
  \ 'coc-styled-components'
\]

" Default to static completion for SQL
let g:omni_sql_default_compl_type = 'syntax'

" Psql
let g:sql_type_default = 'pgsql'
let g:pgsql_pl = ['javascript']

" ---------------------------------------- VIM CONFIG ----------------------------------------- "

set background=dark
set completeopt=menuone,noinsert,noselect
set encoding=utf-8
set guicursor=
set hidden
set hlsearch
set incsearch
set laststatus=2
set lazyredraw
set magic
set nobackup
set nowritebackup
set relativenumber
set shortmess+=c
set showmatch
set signcolumn=yes
set smartcase
set smartindent
set smarttab
set termguicolors
set updatetime=300
set wildmenu
set wildmode=full
colorscheme palenight

" ---------------------------------------- KEY MAPPINGS --------------------------------------- "

" Clear search highlighting
nnoremap <silent> <C-l> :nohlsearch<CR> :syntax sync fromstart<CR><C-l>
" Coc GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Coc use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
" Coc symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Coc rename current file
nmap <leader>rnf :CocCommand workspace.renameCurrentFile<CR>
" Coc formatting selected code.
nmap <F4> <Plug>(coc-format)
" Coc fuzzy file finder
nnoremap ff :CocList gfiles<CR>
nnoremap <leader>rg :CocList grep<CR>
nnoremap gs :CocList gstatus<CR>
" Fast movement
nnoremap <C-j> 5jzz
nnoremap <C-k> 5kzz
" Remap TAB to change tab o.O
noremap <TAB> gt
noremap <S-TAB> gT
" Always go file in new tab
nnoremap gf <C-w>gf
" Git blame
nnoremap gb :echomsg system("git blame -L ".line(".").",".line(".")." ".expand("%"))[:-2]<CR>
" <F3> Open Vifm
nnoremap <expr> <F3> bufname("%") == "" ? ':Vifm<CR>' : ':TabVifm<CR>'
" <F6> JSDoc
nmap <silent> <F6> <Plug>(jsdoc)
" <F7> Save current session
nmap <F7> :mks ~/.vim/sessions/rooster.vim!<CR>
" <F8> Reload last session
nmap <F8> :source ~/.vim/sessions/rooster.vim<CR>
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" ----------------------------------------- FUNCTIONS ----------------------------------------- "

" Coc show documentation on <K>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" ---------------------------------------- AUTOCOMMANDS --------------------------------------- "

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Fix styled-components syntax highlighting
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" -------------------------------------- CUSTOM HIGHLIGHTS ------------------------------------ "

" Coc text hightlight background color on cursor hold
hi CocHighlightText guibg=#32374d
