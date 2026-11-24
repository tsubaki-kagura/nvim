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

keymap('n', 'U', '<c-r>')
keymap('n', '+', '<c-a>')
keymap('n', '-', '<c-x>')
keymap('n', '<leader>rs', '<cmd>restart<cr>')
keymap('n', '<leader>ch', '<cmd>nohlsearch<cr>')
keymap('n', '<a-z>', toggle_textwrap)


local close_other_windows = function()
  local cur_win = vim.api.nvim_get_current_win()
  for _, win in pairs(vim.api.nvim_list_wins()) do
    if cur_win ~= win then
      vim.api.nvim_win_close(win, false)
    end
  end
end

keymap('n', '<leader>wj', '<cmd>split<cr>')
keymap('n', '<leader>wl', '<cmd>vertical split<cr>')
keymap('n', '<leader>wd', '<cmd>close<cr>')
keymap('n', '<leader>wo', close_other_windows)

keymap('n', '<c-h>', '<c-w>h')
keymap('n', '<c-j>', '<c-w>j')
keymap('n', '<c-k>', '<c-w>k')
keymap('n', '<c-l>', '<c-w>l')

keymap('n', '<a-h>', '<cmd>vertical resize +1<cr>')
keymap('n', '<a-j>', '<cmd>resize -1<cr>')
keymap('n', '<a-k>', '<cmd>resize +1<cr>')
keymap('n', '<a-l>', '<cmd>vertical resize -1<cr>')

keymap({ 'n', 'v' }, 'x', '"_x')
keymap({ 'n', 'v' }, 'c', '"_c')

local opts = { expr = true }
local move = function(dir)
  return function()
    return vim.opt_local.wrap:get() and ('g%s'):format(dir) or dir
  end
end

keymap({ 'n', 'v' }, 'j', move('j'), opts)
keymap({ 'n', 'v' }, 'k', move('k'), opts)

keymap({ 'n', 'v', 'o' }, 'H', '^')
keymap({ 'n', 'v', 'o' }, 'L', '$')
