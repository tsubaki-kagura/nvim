vim.opt.termguicolors = true
vim.opt.cmdheight = 0

require('plugins.catppuccin')
require('plugins.lualine')

local ui2 = require('vim._core.ui2')
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

local set_width = vim.api.nvim_win_set_width
vim.api.nvim_win_set_width = function(win, width)
  if win == ui2.wins.msg then
    width = math.min(width, vim.opt_local.columns:get() * 0.4)
  end
  return set_width(win, width)
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
