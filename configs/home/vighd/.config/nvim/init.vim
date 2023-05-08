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
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
  Plug 'windwp/nvim-autopairs'
  Plug 'tpope/vim-dadbod'
  Plug 'kristijanhusak/vim-dadbod-completion'
  Plug 'kristijanhusak/vim-dadbod-ui'
  Plug 'styled-components/vim-styled-components'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'lewis6991/gitsigns.nvim'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
  Plug 'FooSoft/vim-argwrap'
	Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'
  Plug 'neovim/nvim-lspconfig'
call plug#end()

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

-- Setup mason

require("mason").setup()
require("mason-lspconfig").setup()

require("mason-lspconfig").setup_handlers {
    function (server_name)
        require("lspconfig")[server_name].setup {}
    end,
    ["yamlls"] = function ()
      require("lspconfig")["yamlls"].setup {
        settings = {
          yaml = {
            keyOrdering = false
          }     
        }
      }
    end,
    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = bufnr,
      callback = function()
        local opts = {
          focusable = false,
          close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
          border = 'rounded',
          source = 'always',
          prefix = ' ',
          scope = 'cursor',
        }
        vim.diagnostic.open_float(nil, opts)
      end
    }),
    vim.diagnostic.config({
      virtual_text = false,
    })
}

local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
	mapping = {
		['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
		['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i','c'}),
    ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i','c'}),
	},
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
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
set completeopt=menu,menuone,noselect
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
set mouse=
set colorcolumn=80
set ruler
colorscheme onedark

" ---------------------------------------- KEY MAPPINGS --------------------------------------- "

" Clear search highlighting
nnoremap <silent> <C-l> :nohlsearch<CR> :syntax sync fromstart<CR><C-l>
" Telescope fuzzy file finder
nnoremap <leader>ff <cmd>Telescope find_files theme=ivy<cr>
nnoremap <leader>rg <cmd>Telescope live_grep theme=ivy<cr>
" Fast movement
nnoremap <C-j> 5jzz
nnoremap <C-k> 5kzz
" Remap 0 and $
nnoremap <C-A> 0
nnoremap <C-E> $
" Remap TAB to change tab o.O
map <TAB> :bnext<CR>
map <S-TAB> :bprev<CR>
" Always go file in new tab
nnoremap gf <C-w>gf
" Autoformat with <F4>
nnoremap <F4> <cmd>lua vim.lsp.buf.format({async = true})<CR>
" LSP keybindings
nnoremap <leader>gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <leader>gtd <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <leader>gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <leader>gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <leader>gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap K <cmd>lua vim.lsp.buf.hover()<CR>
" Split arguments
nnoremap <silent> <leader>s :ArgWrap<CR>
" Split words into new lines by space
vnoremap S :s/\ /\r/g<CR>

" ---------------------------------------- AUTOCOMMANDS --------------------------------------- "

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
autocmd FileType sql setlocal omnifunc=vim_dadbod_completion#omni
autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
