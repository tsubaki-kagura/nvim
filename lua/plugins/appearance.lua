local opt = vim.opt

opt.termguicolors = true
opt.cmdheight = 0
opt.showtabline = 0
opt.showmode = false

require('vim._core.ui2').enable({
  enable = true,
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

require('catppuccin').setup({
  flavour = 'mocha',
  term_colors = true,
  styles = { conditionals = { } }, -- 去除条件语句斜体
  custom_highlights = function(colors)
    return {
      StatusLine = { bg = colors.base },
      CursorLine = { bg = colors.surface0 },
      Visual = { style = { } }, -- 去除 Visual 粗体
    }
  end,
})

vim.cmd.colorscheme('catppuccin-nvim')
