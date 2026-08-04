return {
    --[[
    -- Lualine
    --]]
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = {
            options = {
                icons_enabled = true,
                globalstatus = false,
                section_separators = { left = '', right = '' },
                component_separators = '|'
            },
            extensions = {
                'mason',
                'oil',
                'trouble',
                'lazy'
            },
            sections = {
                lualine_a = {
                    { 'mode', separator = { right = '' }, right_padding = 2 },
                },
                lualine_b = {
                    'require("workspaces").name()', 'branch', 'diff', 'diagnostics'
                }
            },
            tabline = {}
        }
    },

    -- fidget.nvim
    {
        "j-hui/fidget.nvim",
        opts = {
            progress = {
                suppress_on_insert = true,
                ignore_done_already = true,
                ignore_empty_message = true
            },
            notification = {
                override_vim_notify = true,
                window = {
                    winblend = 0,
                },
            }
        }
    },

    -- icons
    { "echasnovski/mini.icons", lazy = true },
    { "nvim-tree/nvim-web-devicons", lazy = true },

    -- plenary
    { "nvim-lua/plenary.nvim", lazy = true },

    -- ui components
    { "MunifTanjim/nui.nvim", lazy = true },
    { 'andreshazard/vim-freemarker', lazy = false },
}
