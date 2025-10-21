-- onedark.lua - OneDark color scheme

return {
  'navarasu/onedark.nvim',
  priority = 1000,
  config = function()
    require('onedark').load() -- With default settings
  end,
}
