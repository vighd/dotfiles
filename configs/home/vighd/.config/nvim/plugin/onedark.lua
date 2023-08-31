require('onedark').setup {
  style = 'cool',
  term_colors = true,
  ending_tildes = true,
}
require('onedark').load()
vim.cmd [[colorscheme onedark]]
