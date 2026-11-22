local create_autocmd = require('utils').create_autocmd

create_autocmd('UIEnter', {
  callback = function()
    vim.opt.clipboard = 'unnamedplus'
  end,
})

create_autocmd('TextYankPost', {
  callback = function()
    vim.hl.on_yank({ higroup = 'Visual', timeout = 250 })
  end,
})

local use_2space_ft = {
  'lua', 'html', 'css', 'scss', 'javascript', 'typescript', 'javascriptreact',
  'typescriptreact', 'vue', 'xml', 'yaml', 'json', 'jsonc',
}

create_autocmd('FileType', {
  pattern = use_2space_ft,
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

local skip_restore_cursor_ft = { gitcommit = true }

create_autocmd('BufReadPost', {
  callback = function(event)
    if vim.b[event.buf].did_restore_cursor then return end
    local ft = vim.filetype.match({ buf = event.buf })
    if skip_restore_cursor_ft[ft] then return end
    local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
    local lcount = vim.api.nvim_buf_line_count(event.buf)
    if mark[1] < 1 or mark[1] > lcount then return end
    vim.api.nvim_win_set_cursor(0, mark)
  end,
})
