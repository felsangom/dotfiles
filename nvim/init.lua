-- 1. Ativa o cache de byte-compilação (Performance Boost)
if vim.loader then vim.loader.enable() end

-- 2. Define o Mapleader ANTES de tudo (Boas práticas)
-- Garante que plugins que usam leader no carregamento peguem a tecla certa
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- 3. Uso de vim.uv (Neovim 0.10+)
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
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

require("lazy").setup({
    spec = {
        { import = "fsg.plugins" },
    },
    rocks = {
        hererocks = false,
        enabled = false
    },
    install = { colorscheme = { "tokyonight" } },
    checker = {
        enabled = false,
        notify = false -- Verifica updates em background sem popup chato
    },
    change_detection = {
        notify = false, -- Desativa aviso de "config changed" a cada salvamento
    },
})
