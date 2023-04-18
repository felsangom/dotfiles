--[[
-- All keymaps are grouped in this file for convenience
--]]

local function map(mode, lhs, rhs, options)
  local default_options = { noremap = true, silent = true }

  if options then
    default_options = vim.tbl_extend('force', default_options, options)
  end

  vim.api.nvim_set_keymap(mode, lhs, rhs, default_options)
end

-- Change leader to space
vim.g.mapleader = ' '

-- Close current buffer
map('n', '<leader>fa', ':bd<CR>')
-- Close all buffers
map('n', '<leader>ft', ':%bd<CR>')

-- Paste replacing selected text, without losing data
map('x', '<leader>p', '"_dP')
-- Delete without yanking
map('x', '<leader>d', '"_d')

-- jk exits insert mode
map('i', 'jk', '<ESC>')

-- Create/resize splits
map('n', '<leader>|', ':vs<CR>')
map('n', '<leader>-', ':sp<CR>')

--[[
-- Telescope mappings
--]]
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', function() builtin.find_files({ hidden = true }) end, {})
vim.keymap.set('n', '<leader>fg', function() builtin.live_grep({ grep_open_files = false }) end, {})
vim.keymap.set('n', '<leader>fw', builtin.grep_string, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fp', builtin.resume, {})

--[[
-- Nvim-tree mappings
--]]
map('n', '<C-n>', ':NvimTreeToggle<CR>')
