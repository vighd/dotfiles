-- keymaps.lua - General key mappings

-- Tab navigation - switching between tabs
vim.keymap.set('n', '<S-Tab>', ':bprev<CR>', { desc = 'Previous tab', silent = true })
vim.keymap.set('n', '<Tab>', ':bnext<CR>', { desc = 'Next tab', silent = true })

-- Other useful keys
vim.keymap.set('n', '<leader>h', '<cmd>nohlsearch<cr>', { desc = 'No Highlight' })
-- Jump to the start of the line
vim.keymap.set('n', '<C-a>', '^', { desc = 'Jump to start of line' })

-- Fast scrolling
vim.keymap.set('n', '<C-j>', '5jzz', { desc = 'Move down 5 line' })
vim.keymap.set('n', '<C-k>', '5kzz', { desc = 'Move up 5 line' })

-- Diagnostic navigation
vim.keymap.set('n', '<leader>p', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
vim.keymap.set('n', '<leader>n', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
--grr in Normal mode maps to vim.lsp.buf.references()
--gri in Normal mode maps to vim.lsp.buf.implementation()
--gO in Normal mode maps to vim.lsp.buf.document_symbol() (this is analogous to the gO mappings in help buffers and :Man page buffers to show a “table of contents”)
--gra in Normal and Visual mode maps to vim.lsp.buf.code_action()
--CTRL-S in Insert and Select mode maps to vim.lsp.buf.signature_help()

-- Telescope
vim.keymap.set('n', '<leader>FF', '<cmd>Telescope git_status theme=ivy<cr>', { desc = 'Git files' })
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files theme=ivy<cr>', { desc = 'Find files' })
vim.keymap.set('n', '<leader>rg', '<cmd>Telescope live_grep theme=ivy<cr>', { desc = 'Live grep' })

-- LSP keybindings
vim.keymap.set('n', '<F4>', function() vim.lsp.buf.format({ async = true }) end, { desc = 'Format file' })

-- DB UI keybinding
vim.keymap.set('n', '<leader>db', ':DBUIToggle<CR>', { desc = 'Toggle DB UI' })

-- Copilot keybindings
vim.api.nvim_set_keymap('i', '<C-Enter>', 'copilot#Accept("<CR>")', { silent = true, expr = true })
