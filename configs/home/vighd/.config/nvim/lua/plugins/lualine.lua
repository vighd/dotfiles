-- lualine.lua - Status line

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup({
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
  end,
}
