options = { noremap = true }

-- Clear search highlighting
vim.api.nvim_set_keymap('n', '<C-l>', ':nohlsearch<CR> :syntay sync fromstart<CR><C-l>', options)

-- Telescope fuzzy file finder
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files theme=ivy<cr>', options)
vim.api.nvim_set_keymap('n', '<leader>rg', '<cmd>Telescope live_grep theme=ivy<cr>', options)

-- Fast movement up and down
vim.api.nvim_set_keymap('n', '<C-j>', '5jzz', options)
vim.api.nvim_set_keymap('n', '<C-k>', '5kzz', options)

-- Remap 0 and $
vim.api.nvim_set_keymap('n', '<C-A>', '0', options)
vim.api.nvim_set_keymap('n', '<C-E>', '$', options)

-- Remap TAB to change tab o.O
vim.api.nvim_set_keymap('n', '<TAB>', ':bnext<CR>', options)
vim.api.nvim_set_keymap('n', '<S-TAB>', ':bprev<CR>', options)

-- Autoformat with <F4>
vim.api.nvim_set_keymap('n', '<F4>', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', options)

-- LSP keybindings
vim.api.nvim_set_keymap('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', options)
vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', options)
vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', options)
vim.api.nvim_set_keymap('n', '<leader>gtd', '<cmd>lua vim.lsp.buf.type_definition()<CR>', options)
vim.api.nvim_set_keymap('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', options)
vim.api.nvim_set_keymap('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', options)
vim.api.nvim_set_keymap('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', options)
vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', options)
