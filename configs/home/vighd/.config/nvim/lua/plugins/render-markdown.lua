vim.pack.add({ 'https://github.com/MeanderingProgrammer/render-markdown.nvim' })

require('render-markdown').setup({
  anti_conceal = {
    enabled = true,
  },
})
