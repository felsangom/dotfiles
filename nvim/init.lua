if vim.loader then vim.loader.enable() end

require('fsg.node')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "fsg.plugins" },
  },
  rocks = {
      hererocks = false,
      enabled = false
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "tokyonight" } },
  -- automatically check for plugin updates
  checker = { enabled = false },
})
