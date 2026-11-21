vim.opt.cmdheight = 0
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

vim.opt.termguicolors = true
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
  integrations = {
    lualine = {
      mocha = function(colors)
        local extend_theme = function(theme)
          for mode, color in pairs(theme) do
            theme[mode] = {
              a = { bg = color, fg = colors.mantle, gui = 'bold' },
              b = { bg = colors.surface1, fg = colors.text },
              c = { bg = colors.base, fg = colors.text },
            }
          end
          return theme
        end
        return extend_theme({
          normal = colors.lavender,
          insert = colors.blue,
          command = colors.mauve,
          visual = colors.sky,
          terminal = colors.pink,
          replace = colors.red,
          inactive = colors.surface1,
        })
      end,
    },
  },
})

vim.cmd.colorscheme('catppuccin-nvim')

local mini_icons = require('mini.icons')
mini_icons.setup({ style = 'glyph' })
mini_icons.mock_nvim_web_devicons()

vim.opt.showmode = false
vim.opt.showtabline = 0
require('lualine').setup({
  options = {
    theme = 'catppuccin-nvim',
    component_separators = { left = '' },
  },
  sections = { -- 聚焦时的状态栏组件
    lualine_a = {
      {
        'mode',
        separator = { left = '' },
        fmt = function(str)
          local point = str:sub(2, 2) == '-' and 3 or 1
          return str:sub(1, point) .. str:sub(point + 1):lower()
        end,
      },
    },
    lualine_b = {
      {
        'filetype',
        separator = { right = '' },
      }
    },
    lualine_c = {
      {
        'filename',
        shorting_target = 64,
        path = 1,
      }
    },
    lualine_x = {
      {
        'branch',
        icon = '',
      },
      {
        'encoding',
        show_bomb = true,
        fmt = function(str)
          return str:upper()
        end,
      },
      {
        'fileformat',
        symbols = {
          unix = 'LF',
          dos = 'CRLF',
          mac = 'CR',
        },
      },
    },
    lualine_y = {
      {
        'progress',
        separator = { left = '' },
        icon = '',
      },
    },
    lualine_z = {
      {
        'location',
        separator = { right = '' },
      },
    },
  },
  inactive_sections = { -- 离焦时的状态栏组件
    lualine_b = {
      {
        'filetype',
        separator = { left = '', right = '' },
      }
    },
    lualine_c = {
      {
        'filename',
        shorting_target = 64,
        path = 1,
      }
    },
    lualine_x = {
      {
        'encoding',
        show_bomb = true,
        fmt = function(str)
          return str:upper()
        end,
      },
    },
    lualine_y = {
      {
        'progress',
        separator = { left = '', right = '' },
        icon = '',
      },
    },
  },
})
