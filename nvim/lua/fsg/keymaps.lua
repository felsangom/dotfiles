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
map('n', '<leader>e', '<cmd>Oil<CR>')

-- Close current buffer
map('n', '<leader>fa', '<cmd>bd<CR>', { desc = "Close current buffer" })
-- Close all buffers
map('n', '<leader>ft', '<cmd>%bd<CR>', { desc = "Close all buffers" })

-- Paste replacing selected text, without losing data
map('x', '<leader>p', '"_dP', { desc = "Paste without losing clipboard content" })
-- Delete without yanking
map('x', '<leader>d', '"_d', { desc = "Delete without yanking" })


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
map('n', '<leader>|', '<cmd>vs<CR>', { desc = "Create vertical split" })
map('n', '<leader>-', '<cmd>sp<CR>', { desc = "Create horizontal split" })
map('n', '<leader>q', '<cmd>q<CR>', { desc = "Quit" })
map('n', '<C-Up>', '<cmd>resize +2<CR>', { desc = "Increase horizontal split size" })
map('n', '<C-Down>', '<cmd>resize -2<CR>', { desc = "Decrease horizontal split size" })
map('n', '<C-Left>', '<cmd>vertical resize -2<CR>', { desc = "Decrease vertical split size" })
map('n', '<C-Right>', '<cmd>vertical resize +2<CR>', { desc = "Increase vertical split size" })

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf, desc = "Go to previous diagnostic" }
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)

    opts = { buffer = ev.buf, desc = "Go to next diagnostic" }
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

    opts = { buffer = ev.buf, desc = "Go to declaration" }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

    opts = { buffer = ev.buf, desc = "Go to definition" }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)

    opts = { buffer = ev.buf, desc = "Show documentation" }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

    opts = { buffer = ev.buf, desc = "Go to implementation" }
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)

    opts = { buffer = ev.buf, desc = "Signature help" }
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

    opts = { buffer = ev.buf, desc = "Type definition" }
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)

    opts = { buffer = ev.buf, desc = "Rename" }
    vim.keymap.set('n', '<f2>', vim.lsp.buf.rename, opts)

    opts = { buffer = ev.buf, desc = "Code action" }
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)

    opts = { buffer = ev.buf, desc = "Find references" }
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

    opts = { buffer = ev.buf, desc = "Format buffer" }
    vim.keymap.set('n', '<space>fc', function()
      vim.lsp.buf.format { async = true }
    end, opts)

    -- Trouble
    local trouble = require('trouble')
    vim.keymap.set('n', '<leader>tt', function() trouble.toggle() end, { desc = "Toggle trouble" })
    vim.keymap.set('n', '<leader>td', function() trouble.toggle('document_diagnostics') end, { desc = "Toggle document diagnostics" })
    vim.keymap.set('n', '<leader>tw', function() trouble.toggle('workspace_diagnostics') end, { desc = "Toggle workspace diagnostics" })
    vim.keymap.set('n', '<leader>tq', function() trouble.toggle('quickfix') end, { desc = "Toggle quickfix" })
    vim.keymap.set('n', '<leader>tl', function() trouble.toggle('loclist') end, { desc = "Toggle loclist" })
    vim.keymap.set('n', 'gr', function() trouble.toggle('lsp_references') end, { desc = "Toggle LSP references" })
  end
})
