return {
  'stevearc/conform.nvim',
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        astro = { "prettier" },
        json = { "prettier" },
        templ = { "templ" },
      },
    })
  end
}
