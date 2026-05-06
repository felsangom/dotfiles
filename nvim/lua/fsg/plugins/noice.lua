return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
        cmdline = {
            enabled = true,
            view = "cmdline_popup",
        },
        messages = { enabled = true },
        popupmenu = { enabled = false },
        -- Não sobrescreve vim.notify (fidget cuida disso)
        notify = { enabled = false },
        lsp = {
            progress = { enabled = false },
            hover = { enabled = false },
            signature = { enabled = false },
            message = { enabled = false },
        },
        routes = {
            -- Suprime apenas mensagens informativas (ex: "X linhas escritas")
            {
                filter = { event = "msg_show", kind = { "", "echo", "echomsg" } },
                opts = { skip = true },
            },
            -- Erros → vim.notify → fidget
            {
                filter = { event = "msg_show", kind = { "echoerr", "lua_error", "rpc_error", "wmsg" } },
                view = "notify",
            },
            { filter = { event = "msg_showmode" }, opts = { skip = true } },
        },
        views = {
            cmdline_popup = {
                position = { row = "100%", col = 0 },
                size = { width = "100%", height = "auto" },
                border = { style = "none", padding = { 0, 1 } },
                win_options = {
                    winhighlight = "Normal:Normal,FloatBorder:CmpBorder",
                },
            },
        },
    },
}
