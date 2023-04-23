--[[
Basic neovim configs
--]]

local g = vim.g
local o = vim.opt

g.mapleader = ' '
g.maplocalleader = ' '
o.autowrite = true
o.completeopt = "menu,menuone,noselect"
o.conceallevel = 3
o.confirm = true
o.formatoptions = "jcroqlnt"
o.swapfile = false
o.laststatus = 2
o.encoding = "utf-8"
o.showmatch = true
o.ignorecase = true
o.smartcase = true
o.incsearch = true
o.clipboard = "unnamedplus"
o.list = true
o.listchars:append "tab:» ,space:·,trail:·,eol:¬"
o.number = true
o.smarttab = true
o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.hlsearch = false
o.wrap = false
o.scrolloff = 3
o.updatetime = 50
o.hidden = true
o.signcolumn = "yes"
o.cursorline = true
o.mouse:append "a"
o.shortmess:append({ W = true, I = true, c = true, s = true, C = true })
o.relativenumber = true
o.splitbelow = true
o.splitright = true
o.showmode = false
o.termguicolors = true
o.undofile = true
o.undolevels = 10000
g.loaded_perl_provider = 0
