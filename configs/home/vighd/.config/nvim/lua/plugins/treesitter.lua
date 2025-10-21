-- treesitter.lua - Syntax highlighting

return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        'javascript', 'typescript', 'ruby', 'go', 'lua', 'vim',
        'yaml', 'dockerfile', 'markdown', 'cmake', 'bash', 'css',
        'json', 'html', 'tsx', 'comment', 'templ'
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      disable = function(lang, buf)     -- Disable highlighting for big files
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
    })

    -- Filetype detection
    vim.filetype.add({
      extension = {
        templ = "templ",
      },
    })

    -- Rails support
    vim.treesitter.language.register('ruby', 'rails')
  end,
}
