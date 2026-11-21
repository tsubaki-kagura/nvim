vim.g.loaded_remote_plugins = 1
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

local gh = function(repo)
  return ('https://github.com/%s.git'):format(repo)
end

vim.pack.add({
  gh('rachartier/tiny-cmdline.nvim'),
  {
    src = gh('catppuccin/nvim'),
    name = "catppuccin",
  },
  gh('nvim-mini/mini.icons'),
  gh('nvim-lualine/lualine.nvim'),
})

require('plugins.appearance')
