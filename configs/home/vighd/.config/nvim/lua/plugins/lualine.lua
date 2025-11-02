vim.pack.add({
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
})

require("lualine").setup({
  sections = {
    lualine_c = {
      {
        'filename',
        path = 2,
      }
    }
  },
  options = {
    icons_enabled = true,
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  tabline = {
    lualine_a = { 'buffers' },
  }
})
