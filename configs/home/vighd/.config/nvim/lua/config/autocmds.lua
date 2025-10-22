-- autocmds.lua - Automatic commands

-- Set colorscheme to catppuccin
vim.cmd [[colorscheme catppuccin-frappe]]

-- Disable builtin syntax highlighting to use Treesitter
--vim.cmd [[syntax off]]

-- Show diagnostic popup on cursor hold
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = 'rounded',
      source = 'always',
      prefix = ' ',
      scope = 'cursor',
    }
    vim.diagnostic.open_float(opts)
  end
})
