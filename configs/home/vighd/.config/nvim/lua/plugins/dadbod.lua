vim.pack.add({
  "https://github.com/tpope/vim-dadbod",
  "https://github.com/kristijanhusak/vim-dadbod-completion",
  "https://github.com/kristijanhusak/vim-dadbod-ui",
})

-- Enable nerd fonts for dadbod-ui
vim.g.db_ui_use_nerd_fonts = 1

-- Disable automatic execution of SQL on save
vim.g.db_ui_execute_on_save = 0
