return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
        style = 'storm',
        styles = {
            functions = { italic = true },
            keywords = { italic = true },
            conditionals = { italic = true },
            repeats = { italic = true },
            comments = { italic = true }
        },
        on_highlights = function(hl, c)
            local prompt = "#2d3149"

            hl.MsgArea = {
                bg = c.bg_dark,
                fg = c.orange
            }

            hl.CursorLineNr = {
                bg = c.bg,
                fg = c.orange
            }

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

            hl.CmpBorder = { fg = c.blue }
            hl.CmpDocBorder = { fg = c.blue1 }
        end,
    },
    config = function(_, opts)
        require('tokyonight').setup(opts)
        vim.cmd([[colorscheme tokyonight]])
    end
}
