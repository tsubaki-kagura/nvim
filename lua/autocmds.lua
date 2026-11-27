local utils = require('utils')

local create_autocmd = utils.create_autocmd
local toggle_textwrap = utils.toggle_textwrap

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

local prose_ft = { 'markdown', 'text' }

create_autocmd('FileType', {
  pattern = prose_ft,
  callback = function()
    toggle_textwrap(true)
  end,
})

create_autocmd({ 'InsertEnter', 'InsertLeave' }, {
  callback = function(event)
    local ft = vim.bo[event.buf].filetype
    if not vim.list_contains(prose_ft, ft) then
      local win = vim.api.nvim_get_current_win()
      if event.event == 'InsertEnter' then
        vim.wo[win].colorcolumn = ''
      elseif event.event == 'InsertLeave' then
        vim.wo[win].colorcolumn = '100'
      end
    end
  end,
})

local use_2space_ft = {
  'lua', 'html', 'css', 'scss', 'javascript', 'typescript', 'javascriptreact',
  'typescriptreact', 'vue', 'xml', 'yaml', 'json', 'jsonc',
}

create_autocmd('FileType', {
  pattern = use_2space_ft,
  callback = function(event)
    vim.bo[event.buf].tabstop = 2
    vim.bo[event.buf].shiftwidth = 2
  end,
})

local skip_restore_cursor_ft = { gitcommit = true }

create_autocmd('BufReadPost', {
  callback = function(event)
    if vim.b[event.buf].did_restore_cursor then return end
    local ft = vim.bo[event.buf].filetype
    ft = ft ~= '' and ft or vim.filetype.match({ buf = event.buf })
    if ft and skip_restore_cursor_ft[ft] then return end
    local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
    local lcount = vim.api.nvim_buf_line_count(event.buf)
    if mark[1] < 1 or mark[1] > lcount then return end
    vim.api.nvim_win_set_cursor(0, mark)
    vim.b[event.buf].did_restore_cursor = true
  end,
})
