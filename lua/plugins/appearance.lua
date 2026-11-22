vim.opt.cmdheight = 0

require('vim._core.ui2').enable({
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
