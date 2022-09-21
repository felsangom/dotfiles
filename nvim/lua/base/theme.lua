--[[
-- Theme configuration
--]]

local g = vim.g
local o = vim.o

o.termguicolors = true
o.background = "dark"
g.gruvbox_material_background = "medium"
g.gruvbox_material_foreground = "material"
g.gruvbox_material_better_performance = true
g.gruvbox_material_enable_italic = true
g.gruvbox_material_sign_column_background = "grey"
g.gruvbox_material_show_eob = false

vim.cmd([[colorscheme gruvbox-material]])
