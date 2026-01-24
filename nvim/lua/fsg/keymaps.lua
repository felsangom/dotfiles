--[[
-- All keymaps are grouped in this file for convenience
-- Modernized using vim.keymap.set
--]]

local map = vim.keymap.set

-- --- FILE MANAGEMENT & GENERAL ---

-- Oil (File Manager)
map('n', '<leader>e', '<cmd>Oil<CR>', { desc = "Open Oil file manager" })

-- Buffers
map('n', '<leader>fa', '<cmd>bd<CR>', { desc = "Close current buffer" })
map('n', '<leader>ft', '<cmd>%bd|e#|bd#<CR>', { desc = "Close all buffers except current" })
map('n', '<leader>fs', '<cmd>w<CR>', { desc = "Save file" })
map('n', '<leader>bd', '<cmd>bd!<CR>', { desc = "Force delete buffer" })

-- Clipboard & Editing
map('x', '<leader>p', '"_dP', { desc = "Paste without losing clipboard" })
map('x', '<leader>d', '"_d', { desc = "Delete without yanking" })

-- Copy Path (Versão Lua Puro)
map('n', '<leader>cf', function()
    vim.fn.setreg('+', vim.fn.expand("%:t"))
    vim.notify("File name copied", vim.log.levels.INFO)
end, { desc = "Copy file name" })

map('n', '<leader>cp', function()
    vim.fn.setreg('+', vim.fn.expand("%:p"))
    vim.notify("Full path copied", vim.log.levels.INFO)
end, { desc = "Copy full path" })

-- --- NAVIGATION & SPLITS ---

-- Leap.nvim (Seguro)
map({'n', 'x', 'o'}, 's',  '<Plug>(leap-forward)', { desc = "Leap Forward" })
map({'n', 'x', 'o'}, 'S',  '<Plug>(leap-backward)', { desc = "Leap Backward" })
map('n', 'gs', '<Plug>(leap-from-window)', { desc = "Leap from window" })

-- Smart JK Escape (Protegido contra falhas do LuaSnip)
map('i', 'jk', function ()
    local ok, luasnip = pcall(require, "luasnip")
    if ok and luasnip.session.current_nodes[vim.api.nvim_get_current_buf()] then
        luasnip.unlink_current()
    end
    vim.cmd("stopinsert")
end, { desc = "Exit insert mode" })

-- Splits
map('n', '<leader>|', '<cmd>vs<CR>', { desc = "Vertical split" })
map('n', '<leader>-', '<cmd>sp<CR>', { desc = "Horizontal split" })
map('n', '<leader>q', '<cmd>q<CR>', { desc = "Quit" })

-- Resize with Arrows
map('n', '<C-Up>', '<cmd>resize +2<CR>', { desc = "Resize Height +" })
map('n', '<C-Down>', '<cmd>resize -2<CR>', { desc = "Resize Height -" })
map('n', '<C-Left>', '<cmd>vertical resize -2<CR>', { desc = "Resize Width -" })
map('n', '<C-Right>', '<cmd>vertical resize +2<CR>', { desc = "Resize Width +" })

-- --- PLUGINS (Global) ---

-- Fugitive
map('n', '<leader>gb', '<cmd>Git blame<CR>', { desc = "Git blame" })
map('n', '<leader>df', '<cmd>Gdiffsplit<CR>',{ desc = "Git diff" })

-- Workspaces
map('n', '<C-k>', '<cmd>WorkspacesOpen<CR>', { desc = "Open Workspace" })

-- Trouble (Movido para Global para acesso sempre disponível)
map('n', '<leader>tt', '<cmd>Trouble toggle<CR>', { desc = "Toggle Trouble" })
map('n', '<leader>td', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>', { desc = "Document Diagnostics" })
map('n', '<leader>tw', '<cmd>Trouble diagnostics toggle<CR>', { desc = "Workspace Diagnostics" })
map('n', '<leader>tq', '<cmd>Trouble qflist toggle<CR>', { desc = "Quickfix List" })
map('n', '<leader>tr', '<cmd>Trouble lsp_references toggle<CR>', { desc = "LSP References" }) -- Mudei de 'tr' para '<leader>tr'

-- --- LSP CONFIGURATION ---

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local opts = { buffer = ev.buf }

        -- Navigation
        map('n', 'gD', vim.lsp.buf.declaration, vim.tbl_extend('force', opts, { desc = "Go to Declaration" }))
        map('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', opts, { desc = "Go to Definition" }))
        map('n', 'gi', vim.lsp.buf.implementation, vim.tbl_extend('force', opts, { desc = "Go to Implementation" }))
        map('n', '<leader>D', vim.lsp.buf.type_definition, vim.tbl_extend('force', opts, { desc = "Type Definition" }))

        -- Actions & Info
        map('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = "Hover Documentation" }))
        map('n', '<S-k>', vim.lsp.buf.signature_help, vim.tbl_extend('force', opts, { desc = "Signature Help" }))
        map('n', '<f2>', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = "Rename Symbol" }))
        map({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, vim.tbl_extend('force', opts, { desc = "Code Action" }))

        -- Diagnostics (Navegação moderna)
        map('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Prev Diagnostic" })
        map('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Next Diagnostic" })

        -- Formatting
        map('n', '<leader>cx', function()
            vim.lsp.buf.format { async = true }
        end, vim.tbl_extend('force', opts, { desc = "Format Buffer" }))
    end,
})
