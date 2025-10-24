-- mason.lua - LSP, DAP, linter and formatter manager

return {
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },

  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'gopls', 'lua_ls', 'templ', 'html',
        },
      })
    end,
  },
}
