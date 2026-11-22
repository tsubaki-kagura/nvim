local opt = vim.opt

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = -1
opt.shiftround = true
opt.expandtab = true

opt.iskeyword:append('-')

opt.number = true
opt.relativenumber = true
opt.wrap = false

opt.cursorline = true
opt.signcolumn = 'yes'
opt.colorcolumn = '100'

opt.scrolloff = 8
opt.sidescrolloff = 8

opt.title = true
opt.pumheight = 10
opt.pumborder = 'rounded'
opt.winborder = 'rounded'

opt.fillchars:append({ diff = '/', eob = ' ' })

opt.ignorecase = true
opt.smartcase = true

opt.path:append('**')
opt.wildmode = { 'longest:full', 'full' }
opt.wildignore:append({
  '*.o', '*.obj', '*.pyc', '*.class', '*.jar',
  '*/node_modules/*', '*/.git/*', '*/.venv/*',
  '**/target/**', '**/build/**',
})

opt.completeopt = { 'menuone', 'popup', 'noselect' }

opt.swapfile = false
opt.writebackup = false
opt.undofile = true

opt.updatetime = 250
opt.timeoutlen = 250
opt.ttimeoutlen = 0

opt.splitbelow = true
opt.splitright = true
opt.splitkeep = 'screen'

opt.foldmethod = 'expr'
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
opt.foldlevel = 99

opt.report = 0
opt.confirm = true

opt.list = true
opt.listchars:append({
  tab = '󰌒 ',
  trail = '•',
  nbsp = '󱁐',
})
