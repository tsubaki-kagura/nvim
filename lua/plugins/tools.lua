local blink_pairs = require('blink.pairs')

local blink_pairs_setup = function()
  blink_pairs.setup({
    mappings = {
      wrap = {
        ['<c-f>'] = 'motion',
        ['<c-b>'] = 'motion_reverse',
        ['<c-s-b>'] = false,
      },
    },
    highlights = {
      groups = {
        'BlinkPairsText',
        'BlinkPairsLavender',
        'BlinkPairsBlue',
        'BlinkPairsSapphire',
        'BlinkPairsSky',
        'BlinkPairsTeal',
        'BlinkPairsGreen',
      },
      unmatched_group = 'BlinkPairsUnmatched',
      matchparen = {
        include_surrounding = true,
        group = 'BlinkPairsMatchParen',
      },
    },
  })
end

if blink_pairs.library_available() then
  blink_pairs_setup()
else
  blink_pairs.download()
  :timeout(10000)
  :on_resolve(function()
    vim.schedule(function()
      blink_pairs_setup()
    end)
  end)
  :on_reject(function(err)
    vim.schedule(function()
      vim.notify(vim.inspect(err), vim.log.levels.ERROR)
    end)
  end)
end

local hide_dotfiles = true
local hidden_filter = function(entry)
  return not (hide_dotfiles and vim.startswith(entry.name, '.'))
end

local mini_files = require('mini.files')
mini_files.setup({
  content = { filter = hidden_filter },
  mappings = {
    close = 'q',
    go_in_plus = 'l',
    go_out_plus = 'h',
    mark_goto = '\'',
    mark_set = 'm', -- 注意这里标记的是文件夹
    show_help = 'g?',
    synchronize = '=',
  },
  windows = {
    width_focus = 32,
    width_nofocus = 24,
  },
})

local utils = require('utils')
utils.keymap('n', '<leader>me', function()
  if mini_files.close() then return end
  local cwd = vim.fn.getcwd()
  local file = vim.api.nvim_buf_get_name(0)
  if file == '' or vim.fn.filereadable(file) == 0 then
    return mini_files.open(cwd, false) -- 在刚创建的新文件内触发
  end
  local relpath = vim.fs.relpath(cwd, file)
  if not relpath then -- 在非项目目录内的其他文件内触发
    return mini_files.open(file, false)
  end
  local branch, cur = { cwd }, cwd
  local paths = vim.split(relpath, '/', { plain = true })
  for _, part in ipairs(paths) do
    cur = vim.fs.joinpath(cur, part)
    branch[#branch + 1] = cur
  end
  mini_files.open(cwd, false)
  mini_files.set_branch(branch, { depth_focus = #branch })
  mini_files.trim_right()
end)

local toggle_hidden = function()
  hide_dotfiles = not hide_dotfiles
  mini_files.refresh({
    content = { filter = hidden_filter },
  })
end

local open_file_in_new_window = function()
  local entry = mini_files.get_fs_entry()
  if entry == nil then
    return vim.notify('请先保存该条目', vim.log.levels.WARN)
  elseif entry.fs_type ~= 'file' then
    return vim.notify('仅支持在新窗口中打开文件', vim.log.levels.WARN)
  else
    local target, new_win = mini_files.get_explorer_state().target_window
    if target == nil then return end
    vim.api.nvim_win_call(target, function()
      vim.cmd('vertical split')
      new_win = vim.api.nvim_get_current_win()
    end)
    if new_win then
      mini_files.set_target_window(new_win)
      mini_files.go_in({ close_on_file = true })
    end
  end
end

utils.create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(event)
    utils.keymap('n', 'H', toggle_hidden, {
      buffer = event.data.buf_id,
      desc = 'Toggle hidden',
    })
    utils.keymap('n', 'L', open_file_in_new_window, {
      buffer = event.data.buf_id,
      desc = 'Go to entry plus (vsplit)',
    })
  end,
})

require('buffer_manager').setup({
  select_menu_item_commands = {
    edit = { key = 'l', command = 'edit' },
    split_edit = { key = 'L', command = 'vertical split' },
  },
  highlight = 'Normal:BufferManagerNormal',
  order_buffers = 'lastused',
  toggle_key_bindings = { 'q', '<esc>' },
  win_position = { h = 0.5, v = 0.4 }
})

local bmui = require('buffer_manager.ui')
local popup = require('plenary.popup')

local popup_create = popup.create
popup.create = function(what, opts)
  if opts and opts.title then
    opts = vim.tbl_extend('force', opts, { titlehighlight = 'BufferManagerTitle' })
  end
  return popup_create(what, opts)
end

utils.keymap('n', '<leader><space>', bmui.toggle_quick_menu)
