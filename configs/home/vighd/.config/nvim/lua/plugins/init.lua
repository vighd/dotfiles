-- init.lua - Plugin loader file with explicit imports

-- Define all plugins explicitly to avoid loading errors
return {
  -- Color scheme
  require('plugins.catppuccin'),

  -- Status line
  require('plugins.lualine'),

  -- Completion
  require('plugins.cmp'),

  -- LSP configuration
  require('plugins.lsp.mason'),
  require('plugins.lsp.servers'),

  -- GitHub Copilot
  require('plugins.copilot'),

  -- Git support
  require('plugins.gitsigns'),

  -- Telescope - file finder
  require('plugins.telescope'),

  -- Auto pairs
  require('plugins.autopairs'),

  -- Last place
  require('plugins.lastplace'),

  -- Treesitter syntax highlighting
  require('plugins.treesitter'),

  -- Indent guides
  require('plugins.indent-blankline'),

  -- Database manager
  require('plugins.dadbod'),

  -- Colorizer for hex codes
  require('plugins.colorizer'),
}
