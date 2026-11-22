vim.g.loaded_remote_plugins = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_netrw = 1

local providers = { 'node', 'perl', 'python3', 'ruby' }
for _, provider in pairs(providers) do
  vim.g[('loaded_%s_provider'):format(provider)] = 0
end

local gh = function(repo)
  return ('https://github.com/%s.git'):format(repo)
end

vim.pack.add({
  gh('rachartier/tiny-cmdline.nvim'),
  {
    src = gh('catppuccin/nvim'),
    name = 'catppuccin',
  },
  gh('nvim-mini/mini.icons'),
  gh('nvim-lualine/lualine.nvim'),
  gh('saghen/blink.indent'),
  gh('saghen/blink.lib'),
  {
    src = gh('saghen/blink.pairs'),
    version = vim.version.range('*'),
  },
  gh('nvim-mini/mini.files'),
  gh('nvim-lua/plenary.nvim'),
  gh('j-morano/buffer_manager.nvim'),
})

require('plugins.appearance')
require('plugins.tools')
