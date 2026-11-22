local mini_icons = require('mini.icons')
mini_icons.setup({ style = 'glyph' })
mini_icons.mock_nvim_web_devicons()

vim.opt.showmode = false
vim.opt.showtabline = 0

require('lualine').setup({
  options = {
    theme = 'catppuccin-nvim',
    component_separators = { left = '' },
    ignore_focus = { 'minifiles', 'minifiles-help', 'buffer_manager' },
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
      { 'filename', shorting_target = 64, path = 1 }
    },
    lualine_x = {
      { 'searchcount', timeout = 250, icon = '󰱼' },
      { 'branch', icon = '' },
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
      { 'filename', shorting_target = 64, path = 1 }
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
