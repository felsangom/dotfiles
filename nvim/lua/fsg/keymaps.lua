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

-- Oil
map('n', '<leader>e', ':Oil<CR>')

-- Close current buffer
map('n', '<leader>fa', ':bd<CR>')
-- Close all buffers
map('n', '<leader>ft', ':%bd<CR>')

-- Paste replacing selected text, without losing data
map('x', '<leader>p', '"_dP')
-- Delete without yanking
map('x', '<leader>d', '"_d')

-- jk exits insert mode and abandon any snippets
vim.keymap.set('i', 'jk', function ()
  local luasnip = require("luasnip")
  local current_nodes = luasnip.session.current_nodes
  if current_nodes then
    if current_nodes[vim.api.nvim_get_current_buf()] then
      current_nodes[vim.api.nvim_get_current_buf()] = nil
    end
  end

  vim.cmd("stopinsert")
end)

-- Create/resize splits
map('n', '<leader>|', ':vs<CR>')
map('n', '<leader>-', ':sp<CR>')
map('n', '<leader>q', ':q<CR>')
map('n', '<C-Up>', ':resize +2<CR>')
map('n', '<C-Down>', ':resize -2<CR>')
map('n', '<C-Left>', ':vertical resize -2<CR>')
map('n', '<C-Right>', ':vertical resize +2<CR>')

--[[
-- LSP
--]]
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {})
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<f2>', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>fc', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
