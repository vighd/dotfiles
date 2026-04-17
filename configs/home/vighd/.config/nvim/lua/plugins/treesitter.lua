vim.pack.add({ { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" } })

-- nvim-treesitter stores queries under runtime/ which isn't auto-added to rtp
local ts_path = vim.fn.stdpath("data") .. "/site/pack/core/opt/nvim-treesitter/runtime"
if not vim.list_contains(vim.opt.runtimepath:get(), ts_path) then
  vim.opt.runtimepath:append(ts_path)
end

-- Install missing parsers
local desired = {
  'javascript', 'typescript', 'ruby', 'go', 'lua', 'vim',
  'yaml', 'dockerfile', 'markdown', 'cmake', 'bash', 'css',
  'json', 'html', 'tsx', 'comment', 'templ'
}

vim.schedule(function()
  local installed = require('nvim-treesitter.config').get_installed()
  local missing = vim.iter(desired)
    :filter(function(p) return not vim.tbl_contains(installed, p) end)
    :totable()

  if #missing > 0 then
    require('nvim-treesitter').install(missing)
  end
end)

-- Enable highlighting and indentation via FileType autocmd
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local max_filesize = 100 * 1024 -- 100 KB
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
    if ok and stats and stats.size > max_filesize then
      return
    end
    pcall(vim.treesitter.start, args.buf)
    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

-- Rails support
vim.treesitter.language.register('ruby', 'rails')
