return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    cmd = "ConformInfo",
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            sh = { "shfmt" },
            bash = { "shfmt" },
            xml = { "xmllint" },
        },
        default_format_opts = {
            lsp_format = "fallback",
        },
    },
    config = function(_, opts)
        require("conform").setup(opts)
    end,
}
