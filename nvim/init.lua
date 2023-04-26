local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--[[
-- Felipe Gomes neovim config files
-- https://github.com/felsangom/dotfiles
--]]

require('fsg.options')
require('fsg.autocmds')
require('fsg.keymaps')
require("lazy").setup("fsg.plugins")
