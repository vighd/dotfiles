-- options.lua - Basic Neovim settings

-- Basic settings
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Appearance settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true
vim.opt.guicursor = ""
vim.opt.showtabline = 2
vim.opt.cursorline = true
vim.cmd "colorscheme catppuccin-frappe"
vim.opt.list = true
vim.opt.listchars = { tab = '│ ', leadmultispace = '│   ', trail = '·' }

-- Editing settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.mouse = ''

-- Enable completion with Ctrl-N and Ctrl-P
vim.opt.complete:append({ 'o' })
vim.opt.completeopt = 'menuone,noselect,popup'

-- Performance and response time
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.lazyredraw = true

-- Window management
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Diagnostic settings
vim.diagnostic.config({ virtual_text = { current_line = true } })
