-- Main entry point for the LSP module

return {
  { import = 'plugins.lsp.mason' },
  { import = 'plugins.lsp.servers' },
}
