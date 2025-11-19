-- Plugins
require("plugins.lsp-config")
require("plugins.catppuccin")
require("plugins.treesitter")
require("plugins.telescope")
require("plugins.lualine")
require("plugins.copilot")
require("plugins.gitsigns")
require("plugins.dadbod")
require("plugins.colorizer")
require("plugins.autopairs")

-- Base configs
require("core.options")
require("core.autocmds")
require("core.keymaps")
require("core.filetype")

-- LSP
vim.lsp.enable(
  {
    "lua_ls",
    "gopls",
    "ruby_lsp",
    "standardrb",
    "templ",
    "yamlls"
  }
)
