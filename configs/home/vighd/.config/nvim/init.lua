-- Plugins
require("plugins.catppuccin")
require("plugins.treesitter")
require("plugins.telescope")
require("plugins.lualine")
require("plugins.copilot")
require("plugins.indent-blankline")
require("plugins.gitsigns")
require("plugins.dadbod")
require("plugins.colorizer")
require("plugins.autopairs")

-- Base configs
require("config.options")
require("config.autocmds")
require("config.keymaps")
require("config.filetype")

-- LSP
vim.lsp.enable({ "lua", "go", "ruby", "templ" })
