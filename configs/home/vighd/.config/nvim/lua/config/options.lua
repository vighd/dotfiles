-- options.lua - Basic Neovim settings

-- Basic settings
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Appearance settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true
vim.opt.guicursor = ""  -- Block cursor in all modes
vim.opt.showtabline = 2 -- Always show tab line
vim.opt.cursorline = true

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

-- Performance and response time
vim.opt.updatetime = 300  -- Faster completion
vim.opt.lazyredraw = true -- Improve performance for macros and regex

-- Window management
vim.opt.splitright = true
vim.opt.splitbelow = true
