return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require('gitsigns').setup {
      signs = {
        add          = { highlight = 'GitSignsAdd', text = '+' },
        change       = { highlight = 'GitSignsChange', text = '~' },
        delete       = { highlight = 'GitSignsDelete', text = '_' },
        topdelete    = { highlight = 'GitSignsDelete', text = '‾' },
        changedelete = { highlight = 'GitSignsChange', text = '~' },
      },
    }
  end
}
