vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local utils = require('utils')

local keymap = utils.keymap
local toggle_textwrap = utils.toggle_textwrap

keymap('i', 'jk', '<esc>')
keymap('i', '<c-h>', '<left>')
keymap('i', '<c-j>', '<down>')
keymap('i', '<c-k>', '<up>')
keymap('i', '<c-l>', '<right>')

keymap('n', '+', '<c-a>')
keymap('n', '-', '<c-x>')
keymap('n', 'U', '<c-r>')
keymap('n', '<leader>rs', '<cmd>restart<cr>')
keymap('n', '<leader>ch', '<cmd>nohlsearch<cr>')
keymap('n', '<a-z>', toggle_textwrap)

keymap('n', '<leader>wj', '<cmd>split<cr>')
keymap('n', '<leader>wl', '<cmd>vertical split<cr>')
keymap('n', '<leader>wd', '<cmd>close<cr>')
keymap('n', '<leader>wo', function()
  local cur_win = vim.api.nvim_get_current_win()
  for _, win in pairs(vim.api.nvim_list_wins()) do
    if cur_win ~= win then
      vim.api.nvim_win_close(win, false)
    end
  end
end)

keymap('n', '<c-h>', '<c-w>h')
keymap('n', '<c-j>', '<c-w>j')
keymap('n', '<c-k>', '<c-w>k')
keymap('n', '<c-l>', '<c-w>l')

keymap('n', '<a-h>', '<cmd>vertical resize +1<cr>')
keymap('n', '<a-j>', '<cmd>resize -1<cr>')
keymap('n', '<a-k>', '<cmd>resize +1<cr>')
keymap('n', '<a-l>', '<cmd>vertical resize -1<cr>')

keymap('v', 'p', '"_xP')

keymap({ 'n', 'v' }, 'x', '"_x')
keymap({ 'n', 'v' }, 'c', '"_c')

local move = function(dir)
  return function()
    return vim.wo.wrap and ('g%s'):format(dir) or dir
  end
end

keymap({ 'n', 'v' }, 'j', move('j'), { expr = true })
keymap({ 'n', 'v' }, 'k', move('k'), { expr = true })

keymap({ 'n', 'v', 'o' }, 'H', '^')
keymap({ 'n', 'v', 'o' }, 'L', '$')
