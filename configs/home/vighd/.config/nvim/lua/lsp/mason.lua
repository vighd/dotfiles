require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = {
    "lua_ls",
    "tsserver",
    "gopls",
    "yamlls",
    "dockerls",
    "docker_compose_language_service",
    "cmake",
    "clangd",
    "bashls",
    "cssls",
    "jsonls",
    "html"
  }
}
require("mason-lspconfig").setup_handlers {
  function(server_name)
    require("lspconfig")[server_name].setup {}
  end,
  ["yamlls"] = function()
    require("lspconfig")["yamlls"].setup {
      settings = {
        yaml = {
          keyOrdering = false
        }
      }
    }
  end,
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = 'rounded',
        source = 'always',
        prefix = ' ',
        scope = 'cursor',
      }
      vim.diagnostic.open_float(nil, opts)
    end
  }),
  vim.diagnostic.config({
    virtual_text = false,
  })
}
