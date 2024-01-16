options = { noremap = true }

-- Clear search highlighting
vim.keymap.set('n', '<C-l>', ':nohlsearch<CR> :syntax sync fromstart<CR><C-l>', options)

-- Telescope fuzzy file finder
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files theme=ivy<cr>', options)
vim.keymap.set('n', '<leader>rg', '<cmd>Telescope live_grep theme=ivy<cr>', options)

-- Fast movement up and down
vim.keymap.set('n', '<C-j>', '5jzz', options)
vim.keymap.set('n', '<C-k>', '5kzz', options)

-- Remap 0 and $
vim.keymap.set('n', '<C-A>', '0', options)
vim.keymap.set('n', '<C-E>', '$', options)

-- Remap TAB to change tab o.O
vim.keymap.set('n', '<TAB>', ':bnext<CR>', options)
vim.keymap.set('n', '<S-TAB>', ':bprev<CR>', options)

-- Autoformat with <F4>
vim.keymap.set('n', '<F4>', '<cmd>lua require("conform").format({async = true, lsp_fallback = "always"})<CR>', options)

-- LSP keybindings
vim.keymap.set('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', options)
vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', options)
vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', options)
vim.keymap.set('n', '<leader>gtd', '<cmd>lua vim.lsp.buf.type_definition()<CR>', options)
vim.keymap.set('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', options)
vim.keymap.set('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', options)
vim.keymap.set('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', options)
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', options)
vim.keymap.set('n', '<leader>p', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>n', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
