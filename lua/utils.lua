local M = {}

local default_keymap_opts = { remap = false, silent = true }
function M.keymap(mode, lhs, rhs, opts)
  opts = opts and vim.tbl_extend('force', default_keymap_opts, opts or {})
  vim.keymap.set(mode, lhs, rhs, opts)
end

local default_augroup = vim.api.nvim_create_augroup('UserConfig', { clear = true })
function M.create_autocmd(event, opts)
  opts = vim.tbl_extend('force', { group = default_augroup }, opts)
  vim.api.nvim_create_autocmd(event, opts)
end

local textwrap = {
  code = {
    wrap = false,
    linebreak = false,
    colorcolumn = '100',
  },
  prose = {
    wrap = true,
    linebreak = true,
    colorcolumn = '',
  },
}

function M.toggle_textwrap(force_prose)
  local target = vim.opt_local.wrap:get() and 'code' or 'prose'
  local mode = force_prose and 'prose' or target
  local win = vim.api.nvim_get_current_win()
  for key, value in pairs(textwrap[mode]) do
    vim.wo[win][key] = value
  end
end

return M
