--[[
Basic neovim configs
--]]

local g = vim.g
local o = vim.opt

o.swapfile = false
o.laststatus = 2
o.encoding = "utf-8"
o.showmatch = true
o.ignorecase = true
o.incsearch = true
o.clipboard = "unnamedplus"
o.list = true
o.listchars = "tab:» ,space:·,trail:·,eol:¬"
o.number = true
o.smarttab = true
o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.relativenumber = true
o.hlsearch = false
o.wrap = false
o.guicursor = ""
o.scrolloff = 3
o.updatetime = 50
o.hidden = true
o.signcolumn = "yes"
g.syntax_on = true
o.mouse:append "a"
o.shortmess:append "csI"
