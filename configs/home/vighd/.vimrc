" ------------------------------------- PLUGIN MANAGEMENT ------------------------------------- "

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
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'tpope/vim-dadbod'
  Plug 'kristijanhusak/vim-dadbod-ui'
  Plug 'vifm/vifm.vim'
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
  \ 'coc-syntax',
  \ 'coc-eslint',
  \ 'coc-git',
  \ 'coc-lists',
\]

" ---------------------------------------- VIM CONFIG ----------------------------------------- "

set encoding=utf-8
set laststatus=2
set hidden
set magic
set smartcase
set nobackup
set nowritebackup
set updatetime=300
set signcolumn=number
set completeopt=menuone,noinsert,noselect
set shortmess+=c
set guicursor=
set termguicolors
set background=dark
set number
set relativenumber
set signcolumn=yes
set magic
set showmatch
set smartcase
set nohlsearch
set hlsearch
set incsearch
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
" Coc formatting selected code.
nmap <F4> <Plug>(coc-format)
" Coc fuzzy file finder
nnoremap ff :CocList gfiles<CR>
nnoremap <leader>rg :CocList grep<CR>
" Fast movement
nnoremap <C-j> 5jzz
nnoremap <C-k> 5kzz
" Remap TAB to change tab o.O
noremap <TAB> gt
noremap <S-TAB> gT
" Git blame
nnoremap gb :echomsg system("git blame -L ".line(".").",".line(".")." ".expand("%"))[:-2]<CR>
" <F3> Open Vifm
nnoremap <expr> <F3> bufname("%") == "" ? ':Vifm<CR>' : ':TabVifm<CR>'

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

" -------------------------------------- CUSTOM HIGHLIGHTS ------------------------------------ "

" Coc text hightlight background color on cursor hold
hi CocHighlightText guibg=#3e4452
