return {
  "williamboman/mason.nvim",
  dependencies = {
    'neovim/nvim-lspconfig',
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local on_attach = vim.lsp.protocol.on_attach
    local lspconfig = require("lspconfig")
    local util = require "lspconfig/util"

    capabilities.textDocument.completion.completionItem.snippetSupport = true

    require("mason").setup()
    require("mason-lspconfig").setup {
      ensure_installed = {
        "gopls",
        "lua_ls",
        "yamlls",
        "cssls",
        "tsserver",
        "sqls",
        "templ",
        "htmx",
        "html"
      },
    }
    require("mason-lspconfig").setup_handlers {
      lspconfig.gopls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { "gopls" },
        filetypes = { "go", "go.mod", "gotmpl" },
        root_dir = util.root_pattern("go.work", "go.mod", ".git"),
        settings = {
          gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
              unusedparams = true,
            }
          }
        }
      },
      lspconfig.lua_ls.setup {},
      lspconfig.yamlls.setup {
        settings = {
          yaml = {
            keyOrdering = false
          }
        }
      },
      lspconfig.cssls.setup {
        capabilities = capabilities,
      },
      lspconfig.sqls.setup {
        settings = {
          sqls = {
            connections = {
              {
                driver = 'postgresql',
              },
            },
          },
        },
      },
      lspconfig.html.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "html", "templ" },
      }),
      lspconfig.htmx.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "html", "templ" },
      }),
      lspconfig.templ.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      }),
    }
  end
}
