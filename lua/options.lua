vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = -1
vim.o.shiftround = true
vim.o.expandtab = true

vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'

vim.o.termguicolors = true
vim.o.cursorline = true
vim.o.colorcolumn = '100'

vim.o.wrap = false
vim.o.linebreak = false

vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

vim.o.title = true
vim.o.pumheight = 10
vim.o.pumborder = 'rounded'
vim.o.winborder = 'rounded'

vim.opt.iskeyword:append('-')
vim.opt.fillchars:append({ diff = '/', eob = ' ' })

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.completeopt = 'menuone,popup,noselect'

vim.opt.path:append('**')
vim.o.wildmode = 'longest:full,full'
vim.opt.wildignore:append({
  '*.o', '*.obj', '*.pyc', '*.class', '*.jar',
  '*/node_modules/*', '*/.git/*', '*/.venv/*',
  '**/target/**', '**/build/**',
})

vim.o.swapfile = false
vim.o.writebackup = false
vim.o.undofile = true

vim.o.updatetime = 250
vim.o.timeoutlen = 250
vim.o.ttimeoutlen = 0

vim.o.splitbelow = true
vim.o.splitright = true
vim.o.splitkeep = 'screen'

vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldlevel = 99

vim.o.report = 0
vim.o.confirm = true

vim.o.list = true
vim.opt.listchars:append({
  tab = '󰌒 ',
  trail = '•',
  nbsp = '󱁐',
})
