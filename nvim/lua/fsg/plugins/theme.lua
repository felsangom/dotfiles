return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
        style = 'storm',
        styles = {
            functions = { italic = true }
        },
        on_highlights = function(hl, c)
            local prompt = "#2d3149"

            hl.TelescopeNormal = {
                bg = c.bg_dark,
                fg = c.fg_dark,
            }
            hl.TelescopeBorder = {
                bg = c.bg_dark,
                fg = c.bg_dark,
            }
            hl.TelescopePromptNormal = {
                bg = prompt,
            }
            hl.TelescopePromptBorder = {
                bg = prompt,
                fg = prompt,
            }
            hl.TelescopePromptTitle = {
                bg = prompt,
                fg = c.fg_dark,
            }
            hl.TelescopePreviewTitle = {
                bg = c.bg_dark,
                fg = c.fg_dark,
            }
            hl.TelescopeResultsTitle = {
                bg = c.bg_dark,
                fg = c.fg_dark,
            }
        end,
    },
    config = function(_, opts)
        require('tokyonight').setup(opts)
        vim.cmd([[colorscheme tokyonight]])
    end
}

-- return {
--   {
--     'rebelot/kanagawa.nvim',
--     lazy = false,
--     priority = 99999,
--     opts = {
--       commentStyle = { italic = true },
--       functionStyle = { italic = true },
--       keywordStyle = { italic = true },
--       statementStyle = { bold = false },
--       theme = "wave",
--       background = {
--         dark = "wave",
--         light = "lotus",
--       },
--       overrides = function(colors)
--         local theme = colors.theme
--
--         return {
--           Whitespace = { fg = theme.ui.bg_p2 },
--           NonText = { fg = theme.ui.bg_p2 },
--           CursorLine = { bg = theme.ui.bg_p1 },
--
--           -- Telescope
--           TelescopeTitle = { fg = theme.ui.special, bold = true },
--           TelescopePromptNormal = { bg = theme.ui.bg_p1 },
--           TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
--           TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
--           TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
--           TelescopePreviewNormal = { bg = theme.ui.bg_dim },
--           TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
--         }
--       end,
--     },
--     config = function(_, opts)
--       require('kanagawa').setup(opts)
--       vim.cmd([[colorscheme kanagawa]])
--     end,
--   }
-- }
