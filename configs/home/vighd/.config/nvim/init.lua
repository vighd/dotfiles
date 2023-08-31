require('globals.options')
require('globals.remaps')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Onedark colorscheme
  {
    "navarasu/onedark.nvim",
    lauzy = false,
    priority = 1000,
    config = function()
      require('onedark').setup {
        style = 'cool',
        term_colors = true,
        ending_tildes = true,
      }
      require('onedark').load()
      vim.cmd [[colorscheme onedark]]
    end
  },

  -- LSP and completion support
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      local cmp = require 'cmp'

      cmp.setup({
        mapping = {
          ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
          ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
          ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
          ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
        }, {
          { name = 'buffer' },
        }, {
          { name = 'path' },
        })
      })

      -- Set configuration for specific filetype.
      cmp.setup.filetype('gitcommit', {
        { name = 'buffer' },
      })

      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline('/', {
        sources = {
          { name = 'buffer' }
        }
      })
    end
  },
  {
    "williamboman/mason.nvim",
    dependencies = {
      'neovim/nvim-lspconfig',
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup {}
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
    end
  },

  -- Gitsigns
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup {
        signs = {
          add          = { hl = 'GitSignsAdd', text = '+', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
          change       = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
          delete       = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
          topdelete    = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
          changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
        },
      }
    end
  },

  -- Lastplace
  {
    'ethanholz/nvim-lastplace',
    config = function()
      require 'nvim-lastplace'.setup {}
    end
  },

  -- Lualine
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup {
        sections = {
          lualine_c = {
            {
              'filename',
              path = 2,
            }
          }
        },
        options = {
          icons_enabled = true,
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
        },
        tabline = {
          lualine_a = { 'buffers' },
        }
      }
    end
  },

  -- autopairs
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {}
    end
  },

  -- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      local languages = {
        "javascript",
        "go",
        "lua",
        "vim",
        "yaml",
        "dockerfile",
        "cmake",
        "c",
        "bash",
        "css",
        "json",
        "html",
        "tsx",
        "comment"
      }

      require 'nvim-treesitter.configs'.setup {
        ensure_installed = languages,
        highlight = {
          enable = languages,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true
        }
      }
    end
  },

  -- telescope
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  -- doge
  {
    "kkoomen/vim-doge",
    build = ':call doge#install()'
  },

  -- dadbod
  {
    'tpope/vim-dadbod',
    dependencies = { 'kristijanhusak/vim-dadbod-completion', 'kristijanhusak/vim-dadbod-ui' }
  },
})
