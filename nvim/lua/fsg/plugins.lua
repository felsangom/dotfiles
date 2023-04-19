--[[
Packer installation, configuration and plugin management.
--]]

-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  PackerBootstrap = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })

  vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
end

-- Sync packer when plugins.lua changes
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  print("Could not load packer...")
  return
end

packer.startup(function(use)
  use { 'wbthomason/packer.nvim' }
  use { 'kyazdani42/nvim-web-devicons' }
  use { 'kyazdani42/nvim-tree.lua' }
  use { 'airblade/vim-gitgutter' }
  use { 'nvim-treesitter/nvim-treesitter', run = function() require('nvim-treesitter.install').update({ with_sync = true }) end }
  use { 'tpope/vim-fugitive' }
  use { 'nvim-lua/plenary.nvim' }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'nvim-telescope/telescope.nvim', tag = '0.1.0' }
  use { 'echasnovski/mini.nvim', branch = 'stable' }
  use { 'nvim-lualine/lualine.nvim' }
  use { 'stevearc/dressing.nvim' }
  use { 'rebelot/kanagawa.nvim' }
  -- LSP
  use { 'neovim/nvim-lspconfig' }
  use { 'williamboman/mason.nvim', run = function() vim.cmd.MasonUpdate() end }
  use { 'williamboman/mason-lspconfig.nvim' }
  -- Autocompletion
  use { 'hrsh7th/nvim-cmp' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'saadparwaiz1/cmp_luasnip' }
  use { 'L3MON4D3/LuaSnip' }
  use { 'rafamadriz/friendly-snippets' }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PackerBootstrap then
    packer.sync()
  end
end)
