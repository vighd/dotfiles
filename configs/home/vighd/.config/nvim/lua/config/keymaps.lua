-- keymaps.lua - General key mappings

-- Tab navigation - switching between tabs
vim.keymap.set('n', '<S-Tab>', ':bprev<CR>', { desc = 'Previous tab', silent = true })
vim.keymap.set('n', '<Tab>', ':bnext<CR>', { desc = 'Next tab', silent = true })

-- Other useful keys
vim.keymap.set('n', '<leader>h', '<cmd>nohlsearch<cr>', { desc = 'No Highlight' })

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Window left' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Window down' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Window up' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Window right' })

-- Diagnostic navigation
vim.keymap.set('n', '<leader>p', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
vim.keymap.set('n', '<leader>n', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open diagnostic float' })
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'Diagnostics list' })

-- Telescope
vim.keymap.set('n', '<leader>FF', '<cmd>Telescope git_status theme=ivy<cr>', options)
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files theme=ivy<cr>', options)
vim.keymap.set('n', '<leader>rg', '<cmd>Telescope live_grep theme=ivy<cr>', options)

-- LSP keybindings
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover information' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename symbol' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code actions' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Find references' })
vim.keymap.set('n', '<F4>', function() vim.lsp.buf.format({ async = true }) end, { desc = 'Format file' })

-- DB UI keybinding
vim.keymap.set('n', '<leader>db', ':DBUIToggle<CR>', { desc = 'Toggle DB UI' })

-- Copilot keybindings
vim.api.nvim_set_keymap('i', '<C-Enter>', 'copilot#Accept("<CR>")', { silent = true, expr = true })
