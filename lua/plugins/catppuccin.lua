require('catppuccin').setup({
  flavour = 'mocha',
  term_colors = true,
  styles = { conditionals = { } }, -- 去除条件语句斜体
  custom_highlights = function(colors)
    return {
      StatusLine = { bg = colors.base },
      CursorLine = { bg = colors.surface0 },
      Visual = { style = { } }, -- 去除 Visual 粗体
      WinSeparator = { fg = colors.subtext1 },
    }
  end,
  highlight_overrides = {
    mocha = function(colors)
      return {
        TinyCmdlineNormal = { bg = colors.mantle },
        BlinkIndent = { fg = colors.surface1 },
        BlinkIndentLavender = { fg = colors.lavender },
        BlinkPairsText = { fg = colors.text },
        BlinkPairsLavender = { fg = colors.lavender },
        BlinkPairsBlue = { fg = colors.blue },
        BlinkPairsSapphire = { fg = colors.sapphire },
        BlinkPairsSky = { fg = colors.sky },
        BlinkPairsTeal = { fg = colors.teal },
        BlinkPairsGreen = { fg = colors.green },
        BlinkPairsUnmatched = { fg = colors.red },
        BlinkPairsMatchParen = {
          fg = colors.pink,
          bg = colors.surface1,
          style = { 'bold' },
        },
        BufferManagerNormal = {
          fg = colors.blue,
          bg = colors.mantle,
          style = {},
        },
        BufferManagerModified = { fg = colors.sky },
        BufferManagerTitle = { fg = colors.subtext0 },
        PagerNormal = { bg = colors.mantle },
      }
    end,
  },
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
