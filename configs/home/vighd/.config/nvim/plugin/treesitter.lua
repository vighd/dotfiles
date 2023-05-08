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
