return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "mason-org/mason.nvim", config = true },
            { "mason-org/mason-lspconfig.nvim" },
            {
                "folke/lazydev.nvim",
                ft = "lua",
                opts = {
                    library = { path = "${3rd}/luv/library", words = { "vim%.uv" } }
                }
            },
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            vim.diagnostic.config({
                underline = false,
                update_in_insert = false,
                virtual_text = {
                    spacing = 4,
                    source = "if_many",
                    prefix = "●",
                },
                severity_sort = true,
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = " ",
                        [vim.diagnostic.severity.WARN] = " ",
                        [vim.diagnostic.severity.HINT] = " ",
                        [vim.diagnostic.severity.INFO] = " ",
                    }
                }
            })

            local capabilities = vim.tbl_deep_extend(
                "force",
                vim.lsp.protocol.make_client_capabilities(),
                require("cmp_nvim_lsp").default_capabilities()
            )

            vim.lsp.config('*', { capabilities = capabilities })

            vim.lsp.config('lua_ls', {
                settings = {
                    Lua = {
                        workspace = { checkThirdParty = false },
                        completion = { callSnippet = "Replace" },
                        telemetry = { enable = false },
                    },
                },
            })

            vim.lsp.config('ruff', {
                init_options = {
                    settings = { args = {} }
                }
            })

            vim.lsp.config('pyright', {
                settings = {
                    pyright = {
                        disableOrganizeImports = true,
                    },
                    python = {
                        analysis = {
                            typeCheckingMode = "off",
                        },
                    },
                },
            })

            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "ruff", "pyright" },
                automatic_enable = true,
            })
        end,
    },
    {
        "mason-org/mason.nvim",
        opts = {
            ensure_installed = {
                "stylua",
                "shfmt",
            },
        },
        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require("mason-registry")
            local function ensure_installed()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end
            if mr.refresh then
                mr.refresh(ensure_installed)
            else
                ensure_installed()
            end
        end,
    }
}
