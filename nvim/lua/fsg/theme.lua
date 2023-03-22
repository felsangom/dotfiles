--[[
-- Theme configuration
--]]

local g = vim.g
local o = vim.o

o.termguicolors = true
g.everforest_background = "soft"
g.everforest_better_performance = true
g.everforest_enable_italic = true
g.everforest_sign_column_background = "grey"
g.everforest_show_eob = false

vim.cmd([[colorscheme everforest]])
