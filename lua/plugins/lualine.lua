local mini_icons = require('mini.icons')
mini_icons.setup({ style = 'glyph' })
mini_icons.mock_nvim_web_devicons()

vim.opt.showmode = false
vim.opt.showtabline = 0

local register = ''
local lualine = require('lualine')
local create_autocmd = require('utils').create_autocmd

create_autocmd('RecordingEnter', {
  callback = function()
    if register == '' then
      vim.schedule(function()
        register = vim.fn.reg_recording()
        lualine.refresh()
      end)
    end
  end,
})

create_autocmd('RecordingLeave', {
  callback = function()
    if register ~= '' then
      vim.schedule(function()
        register = ''
        lualine.refresh()
      end)
    end
  end,
})

local git_branch = require('lualine.components.branch.git_branch')
local find_git_dir = git_branch.find_git_dir
git_branch.find_git_dir = function(dir_path)
  if not dir_path then
    local name = vim.api.nvim_buf_get_name(0)
    if name == '' or (name:match('^%a[%w+.-]*://') ~= nil and not name:match('^term://')) then
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local file = vim.api.nvim_buf_get_name(buf)
        if vim.bo[buf].buftype == '' and file ~= '' and not file:match('://') then
          dir_path = vim.fn.fnamemodify(file, ':p:h')
          break
        end
      end
    end
  end
  return find_git_dir(dir_path)
end

local mocha_colors = require('catppuccin.palettes').get_palette('mocha')
local common_component_separator = { left = '', right = '' }
local common_components = {
  filetype = {
    'filetype',
    separator = { right = '' },
  },
  encoding = {
    'encoding',
    icon = '',
    color = { fg = mocha_colors.teal },
    fmt = function(str)
      return str:upper()
    end,
  },
  filename = {
    'filename',
    path = 1,
    shorting_target = 64,
    symbols = {
      modified = '󰷬',
      readonly = '󰷧',
      unnamed = '󰄰',
      newfile = '',
    },
  },
  filesize = {
    'filesize',
    icon = '',
    color = { bg = mocha_colors.surface1 },
    separator = common_component_separator,
  },
  fileformat = {
    'fileformat',
    icon = '󰘤',
    color = { fg = mocha_colors.teal },
    symbols = {
      unix = 'LF',
      dos = 'CRLF',
      mac = 'CR',
    },
  },
  progress = {
    'progress',
    separator = { left = '' },
    icon = '',
  },
}

local exception_components = {
  filetype = vim.tbl_extend(
    'force', common_components.filetype,
    { separator = common_component_separator }
  ),
  progress = vim.tbl_extend(
    'force', common_components.progress,
    { separator = common_component_separator }
  ),
}

lualine.setup({
  options = {
    theme = 'catppuccin-nvim',
    component_separators = { left = '' },
    ignore_focus = { 'minifiles', 'minifiles-help', 'buffer_manager', 'pager' },
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
    lualine_b = { common_components.filetype },
    lualine_c = { common_components.encoding, common_components.filename },
    lualine_x = {
      {
        function()
          return register
        end,
        cond = function()
          return register ~= ''
        end,
        fmt = function(reg)
          reg = reg == 'nil' and '' or reg
          return reg ~= '' and (' REC @' .. register) or ''
        end,
        color = { fg = mocha_colors.red },
      },
      {
        'searchcount',
        icon = '󰱼',
        color = { fg = mocha_colors.rosewater },
        timeout = 250,
      },
      {
        'branch',
        icon = '',
        color = { fg = mocha_colors.pink },
      },
      common_components.filesize,
      common_components.fileformat,
    },
    lualine_y = { common_components.progress },
    lualine_z = {
      {
        'location',
        separator = { right = '' },
      },
    },
  },
  inactive_sections = { -- 离焦时的状态栏组件
    lualine_b = { exception_components.filetype },
    lualine_c = { common_components.encoding, common_components.filename },
    lualine_x = { common_components.filesize, common_components.fileformat },
    lualine_y = { exception_components.progress },
  },
})
