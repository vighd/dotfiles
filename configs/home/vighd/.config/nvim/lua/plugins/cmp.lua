return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lsp',
    'SirVer/ultisnips',
    'quangnguyen30192/cmp-nvim-ultisnips',
    'garyhurtz/cmp_bulma.nvim',
  },
  config = function()
    local cmp = require 'cmp'

    cmp.setup({
      preselect = cmp.PreselectMode.None,
      completion = {
        completeopt = "menu,menuone,noselect",
        keyword_length = 3,
      },
      matching = {
        disallow_partial_matching = true,
        disallow_fuzzy_matching = true,
        disallow_prefix_unmatching = true,
      },
      snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
          vim.fn["UltiSnips#Anon"](args.body)
        end,
      },
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
        {
          name = "bulma",
          option = {
            filetypes = {
              "html",
              "templ",
            },
          }
        },
        { name = 'nvim_lsp', keyword_length = 3 },
        { name = 'ultisnips' },
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
}
