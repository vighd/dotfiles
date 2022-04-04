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
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
  Plug 'windwp/nvim-autopairs'
  Plug 'tpope/vim-dadbod'
  Plug 'kristijanhusak/vim-dadbod-ui'
  Plug 'kristijanhusak/vim-dadbod-completion'
  Plug 'styled-components/vim-styled-components'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'lewis6991/gitsigns.nvim'
	Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/nvim-lsp-installer'
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/nvim-cmp'
	Plug 'hrsh7th/cmp-vsnip'
	Plug 'hrsh7th/vim-vsnip'
  Plug 'rafamadriz/friendly-snippets'
call plug#end()

" Installed lsps jsonls vimls tsserver bashls gopls eslint dockerls ansiblels
" cssls html rust_analyzer sqls yamlls

" ------------------------------------- PLUGIN CONFIGS ---------------------------------------- "

lua <<EOF
-- Setup gitsigns

require('gitsigns').setup {
	signs = {
    add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },	
}

-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = {
		['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
		['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
	},
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' }, -- For vsnip users.
	}, {
		{ name = 'buffer' },
	}, {
		{ name= 'path' },
	})
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
	{ name = 'buffer' },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
	sources = {
		{ name = 'buffer' }
	}
})

-- LSP Installer

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
    local opts = {}
    server:setup(opts)
end)

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

" DBUI
let g:db_ui_execute_on_save = 0

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
set expandtab
set noswapfile
colorscheme onedark

" ---------------------------------------- KEY MAPPINGS --------------------------------------- "

" Clear search highlighting
nnoremap <silent> <C-l> :nohlsearch<CR> :syntax sync fromstart<CR><C-l>
" Coc use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
" Coc rename current file
nmap <leader>rnf :CocCommand workspace.renameCurrentFile<CR>
" Telescope fuzzy file finder
nnoremap <leader>ff <cmd>Telescope find_files theme=ivy<cr>
nnoremap <leader>rg <cmd>Telescope live_grep theme=ivy<cr>
" Fast movement
nnoremap <C-j> 5jzz
nnoremap <C-k> 5kzz
" Remap TAB to change tab o.O
map <TAB> :bnext<CR>
map <S-TAB> :bprev<CR>
" Jump forward or backward in vsnip
imap <expr> <Tab>   vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'
" Always go file in new tab
nnoremap gf <C-w>gf
" Autoformat with <F4>
nnoremap <F4> <cmd>lua vim.lsp.buf.formatting()<CR>
" LSP keybindings
nnoremap <leader>gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <leader>gtd <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <leader>gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <leader>gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <leader>gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap K <cmd>lua vim.lsp.buf.hover()<CR>

" ---------------------------------------- AUTOCOMMANDS --------------------------------------- "

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Set up sql completion
autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
