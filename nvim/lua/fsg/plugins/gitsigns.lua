return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        signs = {
            add = { text = "│" },
            change = { text = "│" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
            untracked = { text = "┆" },
        },
        on_attach = function(bufnr)
            local gitsigns = require("gitsigns")

            local function map(mode, lhs, rhs, desc, extra)
                vim.keymap.set(mode, lhs, rhs, vim.tbl_extend('force', { buffer = bufnr, desc = desc }, extra or {}))
            end

            -- Navigation
            map('n', ']c', function()
                if vim.wo.diff then return ']c' end
                vim.schedule(gitsigns.next_hunk)
                return '<Ignore>'
            end, "Next Hunk", { expr = true })

            map('n', '[c', function()
                if vim.wo.diff then return '[c' end
                vim.schedule(gitsigns.prev_hunk)
                return '<Ignore>'
            end, "Prev Hunk", { expr = true })

            -- Actions
            map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>', "Stage Hunk")
            map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>', "Reset Hunk")
            map('n', '<leader>hp', gitsigns.preview_hunk, "Preview Hunk")
            map('n', '<leader>hb', function() gitsigns.blame_line({ full = true }) end, "Blame Line")
            map('n', '<leader>hB', gitsigns.toggle_current_line_blame, "Toggle Line Blame")
        end,
    },
}
