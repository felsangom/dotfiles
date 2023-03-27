--[[
-- Theme configuration
--]]

local g = vim.g
local o = vim.o

o.termguicolors = true

require('kanagawa').setup({
  compile = false,
  undercurl = true,
  commentStyle = { italic = true },
  functionStyle = { italic = true },
  keywordStyle = { italic = true},
  statementStyle = { bold = true },
  typeStyle = {},
  transparent = false,
  dimInactive = false,
  terminalColors = true,
  colors = {
    palette = {},
    theme = { wave = {}, lotus = {}, dragon = {}, all = {} }
  },
  overrides = function(colors)
    theme = colors.theme

    return {
      Whitespace = { fg = theme.ui.bg_p2 },
      NonText = { fg = theme.ui.bg_p2 }
    }
  end,
  theme = "wave",
  background = {
    dark = "wave",
    light = "lotus"
  }
})

vim.cmd([[colorscheme kanagawa]])
