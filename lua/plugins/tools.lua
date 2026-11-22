local pairs = require('blink.pairs')

local pairs_setup = function()
  pairs.setup({
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

if pairs.library_available() then
  pairs_setup()
else
  pairs.download()
    :timeout(10000)
    :on_resolve(function()
      vim.schedule(function()
        pairs_setup()
      end)
    end)
    :on_reject(function(err)
      vim.schedule(function()
        if pairs.library_available() then
          pairs_setup()
        else
          vim.notify(vim.inspect(err), vim.log.levels.ERROR)
        end
      end)
    end)
end
