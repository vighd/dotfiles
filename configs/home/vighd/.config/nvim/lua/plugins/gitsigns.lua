-- gitsigns.lua - Git integration

return {
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup()
  end,
}
