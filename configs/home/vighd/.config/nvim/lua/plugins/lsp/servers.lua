-- servers.lua - LSP servers configuration

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- LSP server registration function for Neovim 0.11.4
    local function setup_lsp_servers()
      -- Filetypes and server configurations
      local servers = {
        gopls = { filetypes = { "go", "gomod", "gowork", "gotmpl" } },
        solargraph = {
          filetypes = { "ruby" },
          settings = {
            solargraph = {
              diagnostics = true,
              formatting = false,
              useBundler = true,
            }
          },
          init_options = {
            enablePages = true,
            completion = true,
            diagnostic = true,
            formatting = false,
            folding = true,
            hover = true,
            references = true,
            rename = true,
            symbols = true,
          }
        },
        lua_ls = {
          filetypes = { "lua" },
          settings = {
            Lua = {
              diagnostics = { globals = { 'vim' } },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
              telemetry = { enable = false },
            },
          },
        },
        templ = { filetypes = { "templ" } },
        html = { filetypes = { "html", "templ", "htmx" } },
      }

      for server_name, config in pairs(servers) do
        for _, filetype in ipairs(config.filetypes or {}) do
          vim.api.nvim_create_autocmd("FileType", {
            pattern = filetype,
            callback = function()
              vim.lsp.start({
                name = server_name,
                cmd = vim.fn.executable(server_name) == 1 and { server_name } or nil,
                root_dir = vim.fs.dirname(vim.fs.find({
                  ".git", "go.mod", "Gemfile", "package.json",
                }, { upward = true })[1] or vim.fn.getcwd()),
                capabilities = capabilities,
                settings = config.settings or {},
              })
            end,
          })
        end
      end
    end

    setup_lsp_servers()
  end,
}
