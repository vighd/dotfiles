-- Filetype detection
vim.filetype.add({
  extension = {
    templ = "templ",
    vifm = "vim",
  },
  filename = {
    ["docker-compose.yml"] = "yaml.docker-compose",
  }
})
