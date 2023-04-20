--[[
Basic neovim configs
--]]

local g = vim.g
local o = vim.opt

g.mapleader = ' '
g.maplocalleader = ' '
o.swapfile = false
o.laststatus = 2
o.encoding = "utf-8"
o.showmatch = true
o.ignorecase = true
o.smartcase = true
o.incsearch = true
o.clipboard = "unnamedplus"
o.list = true
o.listchars = "tab:» ,space:·,trail:·,eol:¬"
o.number = true
o.smarttab = true
o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.hlsearch = false
o.wrap = false
o.guicursor = ""
o.scrolloff = 3
o.updatetime = 50
o.hidden = true
o.signcolumn = "yes"
o.cursorline = true
o.mouse:append "a"
o.shortmess:append "csI"
o.relativenumber = true
o.splitbelow = true
o.splitright = true
o.showmode = false
o.termguicolors = true
g.loaded_perl_provider = 0
