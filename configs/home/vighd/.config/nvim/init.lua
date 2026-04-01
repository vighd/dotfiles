-- Plugins
require("plugins.lsp-config")
--require("plugins.catppuccin")
require("plugins.gruvbox")
require("plugins.treesitter")
require("plugins.telescope")
require("plugins.lualine")
require("plugins.gitsigns")
require("plugins.dadbod")
require("plugins.autopairs")
require("plugins.render-markdown")
require("plugins.git-conflict")

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
