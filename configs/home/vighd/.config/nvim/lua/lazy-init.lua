local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  'navarasu/onedark.nvim',
  'nvim-lualine/lualine.nvim',
  'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope.nvim',
  'windwp/nvim-autopairs',
  'nvim-treesitter/nvim-treesitter',
  'lewis6991/gitsigns.nvim',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',
  'ethanholz/nvim-lastplace',
  'tpope/vim-dadbod',
  'kristijanhusak/vim-dadbod-completion',
  'kristijanhusak/vim-dadbod-ui',
  'kkoomen/vim-doge',
  'jose-elias-alvarez/null-ls.nvim',
}

local opts = {}

require("lazy").setup(plugins, opts)
