local gh = function(repo)
    return ('https://github.com/%s.git'):format(repo)
end

vim.pack.add({
    gh('rachartier/tiny-cmdline.nvim'),
})

require('plugins.appearance')
