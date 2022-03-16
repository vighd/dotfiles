" ------------------------------------- PLUGIN MANAGEMENT ------------------------------------- "

let plug=expand(stdpath('data') . '/site/autoload/plug.vim')
if !filereadable(plug)
  echo "Installing Plugin manager.."
  silent !sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin(stdpath('data') . '/plugged')
  Plug 'navarasu/onedark.nvim'
	Plug 'arcticicestudio/nord-vim'
  Plug 'nvim-lualine/lualine.nvim'
	Plug 'kyazdani42/nvim-web-devicons'
	Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
  Plug 'windwp/nvim-autopairs'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'tpope/vim-dadbod'
  Plug 'kristijanhusak/vim-dadbod-ui'
  Plug 'styled-components/vim-styled-components'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

" ------------------------------------- PLUGIN CONFIGS ---------------------------------------- "

lua <<EOF
-- Treesitter

require'nvim-treesitter.configs'.setup {
  ensure_installed = {
      "javascript",
      "go",
      "lua",
      "vim",
      "yaml",
      "dockerfile",
      "cmake",
      "c", 
      "bash",
      "css",
      "json",
      "html",
      "tsx",
      "comment"
  },
  highlight = {
    enable = {
      "javascript",
      "go",
      "lua",
      "vim",
      "yaml",
      "dockerfile",
      "cmake",
      "c", 
      "bash",
      "css",
      "json",
      "html",
      "tsx",
      "comment"
    },
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
  }
}

-- Auto pairs

require('nvim-autopairs').setup{}

-- Lualine

require('lualine').setup {
  options = {
    icons_enabled = true,
		component_separators = {left = '', right = ''},
    section_separators = {left = '', right = ''},
  },
	tabline = {
  	lualine_a = {'buffers'},
	}
}
EOF

" Colorscheme
let g:onedark_config = {
  \ 'style': 'cool',
\}

" Set leader key
let mapleader = ","

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
  \ 'coc-styled-components',
  \ 'coc-snippets'
\]

" Default to static completion for SQL
let g:omni_sql_default_compl_type = 'syntax'

" DBUI
let g:db_ui_execute_on_save = 0

" Hexokinase
let g:Hexokinase_highlighters = ['backgroundfull']

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
set shiftwidth=2
set tabstop=2
set showtabline=1
colorscheme onedark

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
" Telescope fuzzy file finder
nnoremap <leader>ff <cmd>Telescope find_files theme=ivy<cr>
nnoremap <leader>rg <cmd>Telescope live_grep theme=ivy<cr>
" Fast movement
nnoremap <C-j> 5jzz
nnoremap <C-k> 5kzz
" Remap TAB to change tab o.O
noremap <TAB> :bnext<CR>
noremap <S-TAB> :bprev<CR>
" Always go file in new tab
nnoremap gf <C-w>gf
" Git blame
nnoremap gb :echomsg system("git blame -L ".line(".").",".line(".")." ".expand("%"))[:-2]<CR>
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
