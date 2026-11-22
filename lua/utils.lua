local M = {}

local default_keymap_opts = { remap = false, silent = true }
function M.keymap(mode, lhs, rhs, opts)
  opts = opts and vim.tbl_extend('force', default_keymap_opts, opts)
  vim.keymap.set( mode, lhs, rhs, opts)
end

local default_augroup = vim.api.nvim_create_augroup('UserConfig', { clear = true })
function M.create_autocmd(event, opts)
  opts = vim.tbl_extend('force', { group = default_augroup }, opts)
  vim.api.nvim_create_autocmd(event, opts)
end

return M
