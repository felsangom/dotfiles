return {
    -- LSP Configuration
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "williamboman/mason.nvim", config = true },
            { "williamboman/mason-lspconfig.nvim" },
            { "folke/neoconf.nvim", cmd = "Neoconf", config = true, opts = {} },
            {
                "folke/lazydev.nvim",
                ft = "lua",
                opts = {
                    library = { path = "${3rd}/luv/library", words = { "vim%.uv" } }
                }
            },
            "hrsh7th/cmp-nvim-lsp",
        },
        opts = {
            diagnostics = {
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
                        [vim.diagnostic.severity.ERROR] = " ",
                        [vim.diagnostic.severity.WARN] = " ",
                        [vim.diagnostic.severity.HINT] = " ",
                        [vim.diagnostic.severity.INFO] = " ",
                    }
                }
            },
            -- Definição dos Servidores
            servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            workspace = { checkThirdParty = false },
                            completion = { callSnippet = "Replace" },
                            telemetry = { enable = false },
                        },
                    },
                },

                -- 1. TYPE CHECKER (IntelliSense)
                pyright = {
                    settings = {
                        python = {
                            analysis = {
                                typeCheckingMode = "basic",
                                autoSearchPaths = true,
                                useLibraryCodeForTypes = true,
                                diagnosticMode = "workspace",
                            },
                        },
                    },
                },

                -- 2. LINTER & FORMATTER
                ruff = {
                    init_options = {
                        settings = {
                            -- Argumentos extras para o ruff CLI, se necessário
                            args = {},
                        }
                    }
                },
            },
        },
        config = function(_, opts)
            vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                require("cmp_nvim_lsp").default_capabilities()
            )

            -- Função de Setup Unificada
            local function setup(server_name)
                local server_opts = opts.servers[server_name] or {}
                server_opts.capabilities = vim.tbl_deep_extend("force", capabilities, server_opts.capabilities or {})

                -- Desativar formatação do Pyright para evitar conflito com Ruff
                if server_name == "pyright" then
                    server_opts.on_attach = function(client, _)
                        client.server_capabilities.documentFormattingProvider = false
                        client.server_capabilities.documentRangeFormattingProvider = false
                    end
                end

                vim.lsp.config[server_name] = server_opts
                vim.lsp.enable(server_name)
            end

            local mlsp = require("mason-lspconfig")
            local ensure_installed = vim.tbl_keys(opts.servers or {})

            mlsp.setup({
                ensure_installed = ensure_installed,
                handlers = {
                    function(server_name)
                        setup(server_name)
                    end,
                },
            })
        end,
    },

    -- Ferramentas CLI extras
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "stylua", -- Formatter Lua
                "shfmt",  -- Formatter Shell
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
