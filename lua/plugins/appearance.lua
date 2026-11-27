vim.opt.termguicolors = true
vim.opt.cmdheight = 0

require('plugins.catppuccin')
require('plugins.lualine')

local ui2 = require('vim._core.ui2')
local ui2_cmdline = require('vim._core.ui2.cmdline')
local ui2_messages = require('vim._core.ui2.messages')
local utils = require('utils')
local cmdline = require('tiny-cmdline')
local indent = require('blink.indent')

ui2.enable({
  msg = {
    target = 'msg',
    targets = {
      emsg = 'pager',
      echoerr = 'pager',
      lua_error = 'pager',
      rpc_error = 'pager',
      list_cmd = 'pager',
      shell_cmd = 'pager',
      shell_out = 'pager',
      shell_ret = 'pager',
      shell_err = 'pager',
      verbose = 'pager',
    },
    msg = { height = 0.3, timeout = 5000 },
    pager = { height = 0.5 },
  },
})

local override_config = function(original_config, config)
  return vim.tbl_extend('force', original_config, {
    title_pos = 'center',
    border = 'rounded',
    row = original_config.row - 1,
  }, config)
end

local set_config = vim.api.nvim_win_set_config
vim.api.nvim_win_set_config = function(win, config)
  if config.row ~= nil then
    if win == ui2.wins.pager then
      config = override_config(config, { title = ' Pager ' })
    elseif win == ui2.wins.dialog then
      config = override_config(config, { title = ' Dialog ' })
    elseif win == ui2.wins.msg then
      config = override_config(config, {
        title = ' Message ',
        title_pos = 'left',
        row = config.row,
      })
    end
  end
  return set_config(win, config)
end

local show_msg = ui2_messages.show_msg
local set_pos = ui2_messages.set_pos

local fit_msg_width = function()
  local win, width = ui2.wins.msg, 1
  if not vim.api.nvim_win_is_valid(win) then return end
  for _, line in ipairs(vim.api.nvim_buf_get_lines(ui2.bufs.msg, 0, -1, false)) do
    width = math.max(width, vim.fn.strdisplaywidth(line))
  end
  ui2_messages.msg.width = math.min(width, math.floor(vim.o.columns * 0.4))
  vim.api.nvim_win_set_width(win, ui2_messages.msg.width)
  if not vim.api.nvim_win_get_config(win).hide then
    set_pos('msg')
  end
end

ui2_messages.show_msg = function(tgt, ...)
  local ret = show_msg(tgt, ...)
  if tgt == 'msg' then
    fit_msg_width()
  end
  return ret
end

ui2_messages.set_pos = function(tgt, ...)
  local ret = set_pos(tgt, ...)
  if tgt == nil or tgt == 'msg' then
    fit_msg_width()
  end
  return ret
end

local cmdline_show = ui2_cmdline.cmdline_show
ui2_cmdline.cmdline_show = function(content, pos, firstc, prompt, indent, level, hl_id)
  if firstc == '/' or firstc == '?' then
    firstc = firstc == '/' and 'Forward (󱞣):' or 'Backward (󱞿):'
    hl_id = vim.api.nvim_get_hl_id_by_name('SearchPrefix')
    indent = 1
  end
  return cmdline_show(content, pos, firstc, prompt, indent, level, hl_id)
end

utils.create_autocmd('FileType', {
  pattern = { 'pager', 'msg', 'dialog' },
  callback = function()
    vim.opt_local.winhighlight = 'Normal:MessageNormal'
    utils.toggle_textwrap(true)
  end,
})

cmdline.setup({
  position = { x = '50%', y = '25%' },
  title = { enabled = true, pos = 'left' },
})

indent.setup({
  mappings = {
    object_scope = 'ii', -- 特殊文本对象, 表示当前缩进内的所有行
    object_scope_with_border = 'ai', -- 类似于 ii, 但额外包括缩进的头和尾
    goto_top = '[i',
    goto_bottom = ']i',
  },
  static = {
    char = '│',
    highlights = { 'BlinkIndent' },
  },
  scope = {
    char = '│',
    indent_at_cursor = true,
    highlights = { 'BlinkIndentLavender' },
  },
})
