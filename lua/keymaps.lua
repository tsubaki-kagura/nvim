vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local keymap = vim.keymap
local opts = { remap = false, silent = true }
local expr_opts = vim.tbl_extend('force', opts, { expr = true })

keymap.set('i', 'jk', '<esc>', opts)
keymap.set('i', '<c-h>', '<left>', opts)
keymap.set('i', '<c-j>', '<down>', opts)
keymap.set('i', '<c-k>', '<up>', opts)
keymap.set('i', '<c-l>', '<right>', opts)

keymap.set('n', 'U', '<c-r>', opts)
keymap.set('n', '+', '<c-a>', opts)
keymap.set('n', '-', '<c-x>', opts)
keymap.set('n', '<leader>rs', '<cmd>restart<cr>', opts)
keymap.set('n', '<leader>ch', '<cmd>nohlsearch<cr>', opts)

local close_other_windows = function()
  local cur_win = vim.api.nvim_get_current_win()
  for _, win in pairs(vim.api.nvim_list_wins()) do
    if cur_win ~= win then
      vim.api.nvim_win_close(win, false)
    end
  end
end

keymap.set('n', '<leader>wj', '<cmd>split<cr>', opts)
keymap.set('n', '<leader>wl', '<cmd>vertical split<cr>', opts)
keymap.set('n', '<leader>wd', '<cmd>close<cr>', opts)
keymap.set('n', '<leader>wo', close_other_windows, opts)

keymap.set('n', '<c-h>', '<c-w>h', opts)
keymap.set('n', '<c-j>', '<c-w>j', opts)
keymap.set('n', '<c-k>', '<c-w>k', opts)
keymap.set('n', '<c-l>', '<c-w>l', opts)

keymap.set('n', '<a-h>', '<cmd>vertical resize +1<cr>', opts)
keymap.set('n', '<a-j>', '<cmd>resize -1<cr>', opts)
keymap.set('n', '<a-k>', '<cmd>resize +1<cr>', opts)
keymap.set('n', '<a-l>', '<cmd>vertical resize -1<cr>', opts)

keymap.set({ 'n', 'v' }, 'x', '"_x', opts)
keymap.set({ 'n', 'v' }, 'c', '"_c', opts)

local move = function(direction)
  return function()
    return vim.opt_local.wrap:get() and 'g' .. direction or direction
  end
end

keymap.set({ 'n', 'v' }, 'j', move('j'), expr_opts)
keymap.set({ 'n', 'v' }, 'k', move('k'), expr_opts)

keymap.set({ 'n', 'v', 'o' }, 'H', '^', opts)
keymap.set({ 'n', 'v', 'o' }, 'L', '$', opts)
