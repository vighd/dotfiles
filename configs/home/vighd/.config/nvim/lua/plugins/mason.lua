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
        "ts_ls",
        "templ",
        "htmx",
        "html",
        "emmet_language_server",
        "eslint"
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
      lspconfig.astro.setup{},
      lspconfig.eslint.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = true
          if client.server_capabilities.documentFormattingProvider then
            local au_lsp = vim.api.nvim_create_augroup("eslint_lsp", { clear = true })
            vim.api.nvim_create_autocmd("BufWritePre", {
              pattern = "*",
              callback = function()
                vim.lsp.buf.format({ async = true })
              end,
              group = au_lsp,
            })
          end
        end,

        filetypes = { "javascript", "javascriptreact" },
      }),
      lspconfig.ts_ls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "javascript", "javascriptreact", "typescriptreact", "typescript" },
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
      lspconfig.emmet_language_server.setup({
        filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "pug", "typescriptreact", "templ" },
        -- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
        -- **Note:** only the options listed in the table are supported.
        init_options = {
          ---@type table<string, string>
          includeLanguages = {},
          --- @type string[]
          excludeLanguages = {},
          --- @type string[]
          extensionsPath = {},
          --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
          preferences = {},
          --- @type boolean Defaults to `true`
          showAbbreviationSuggestions = true,
          --- @type "always" | "never" Defaults to `"always"`
          showExpandedAbbreviation = "always",
          --- @type boolean Defaults to `false`
          showSuggestionsAsSnippets = false,
          --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
          syntaxProfiles = {},
          --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
          variables = {},
        },
      })

    }
  end
}
