vim.opt.termguicolors = true
vim.opt.cmdheight = 0

local ui2 = require('vim._core.ui2')

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

local set_config = vim.api.nvim_win_set_config
vim.api.nvim_win_set_config = function(win, config)
  if win == ui2.wins.pager and config.row ~= nil then
    config = vim.tbl_extend('force', config, {
      title = ' Messages ',
      title_pos = 'center',
      border = 'rounded',
      row = config.row - 1,
    })
  end
  return set_config(win, config)
end

require('utils').create_autocmd('FileType', {
  pattern = 'pager',
  callback = function()
    vim.opt_local.winhighlight = 'Normal:PagerNormal'
  end,
})

require('tiny-cmdline').setup({
  position = { x = '50%', y = '25%' },
  title = { enabled = true, pos = 'left' },
})

require('plugins.catppuccin')
require('plugins.lualine')

require('blink.indent').setup({
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
