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

-- jk exits insert mode
map('i', 'jk', '<ESC>')

--[[
-- Telescope mappings
--]]
map('n', '<leader>ff', '<cmd>lua require(\'telescope.builtin\').find_files({ hidden = true })<cr>')
map('n', '<leader>fg', '<cmd>lua require(\'telescope.builtin\').live_grep({grep_open_files = false})<cr>')
map('n', '<leader>fb', '<cmd>lua require(\'telescope.builtin\').buffers()<cr>')
map('n', '<leader>fh', '<cmd>lua require(\'telescope.builtin\').help_tags()<cr>')

--[[
-- Nvim-tree mappings
--]]
map('n', '<C-n>', ':NvimTreeToggle<CR>')

--[[
-- CoC mappings
--]]

-- Tab and Shift Tab to cycle between suggestions
map('i', '<TAB>', 'coc#pum#visible() ? coc#pum#next(1) : CheckBackspace() ? "<Tab>" : coc#refresh()', { expr = true })
map('i', '<S-TAB>', 'coc#pum#visible() ? coc#pum#prev(1) : "<C-h>"', { expr = true, silent = false })

-- Control space to trigger completion
map('i', '<c-space>', 'coc#refresh()', { expr = true })

-- Enter to accept current selected suggestion
map('i', '<CR>', 'coc#pum#visible() ? coc#pum#confirm() : "<C-g>u<CR><c-r>=coc#on_enter()<CR>"', { expr = true })

-- [g and ]g to navigate diagnostics
map('n', '[g', '<Plug>(coc-diagnostic-prev)', { noremap = false })
map('n', ']g', '<Plug>(coc-diagnostic-next)', { noremap = false })

-- Gotos maps
map('n', 'gd', '<Plug>(coc-definition)', { noremap = false })
map('n', 'gy', '<Plug>(coc-type-definition)', { noremap = false })
map('n', 'gi', '<Plug>(coc-implementation)', { noremap = false })
map('n', 'gr', '<Plug>(coc-references)', { noremap = false })

-- K to show documentation in preview window
map('n', 'K', ':call ShowDocumentation()<CR>')

-- F2 to rename current word
map('n', '<F2>', '<Plug>(coc-rename)', { noremap = false })

-- CocList mappings
-- Show all diagnostics
map('n', '<space>a', ':<C-u>CocList diagnostics<CR>')
-- Manage extensions
map('n', '<space>e', ':<C-u>CocList extensions<CR>')
-- Find symbol in current document
map('n', '<space>o', ':<C-u>CocList outline<CR>')
-- Find symbol in workspace
map('n', '<space>s', ':<C-u>CocList -I symbols<CR>')
-- Default action for next item
map('n', '<space>j', ':<C-u>CocNext<CR>')
-- Default action for previous item
map('n', '<space>k', ':<C-u>CocPrev<CR>')
-- Resume latest coc list
map('n', '<space>p', ':<C-u>CocListResume<CR>')

-- Coc snippets mappings
-- Use <C-l> for trigger snippet expand
map('i', '<C-l>', '<Plug>(coc-snippets-expand)', { noremap = false, silent = false })
-- Use <C-j> for select text for visual placeholder of snippet
map('v', '<C-j>', '<Plug>(coc-snippets-select)', { noremap = false, silent = false })
map('i', '<C-j>', '<Plug>(coc-snippets-expand-jump)', { noremap = false, silent = false })
-- Use <leader>x to convert visual selected code to snippet
map('x', '<leader>x', '<Plug>(coc-convert-snippet)')
