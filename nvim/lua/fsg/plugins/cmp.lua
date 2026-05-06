return {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
    },
    opts = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        local icons = require("mini.icons")

        return {
            window = {
                completion = {
                    border = "rounded",
                    winhighlight = "Normal:Normal,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
                    scrollbar = false,
                },
                documentation = {
                    border = "rounded",
                    winhighlight = "Normal:Normal,FloatBorder:CmpDocBorder,CursorLine:PmenuSel,Search:None",
                    scrollbar = false,
                },
            },
            completion = {
                completeopt = "menu,menuone",
                get_trigger_characters = function(trigger_characters)
                    local filter_characters = function(char)
                        return char ~= ' ' and char ~= '\t'
                    end
                    return vim.tbl_filter(filter_characters, trigger_characters)
                end
            },
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            mapping = {
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.close(),
                ["<CR>"] = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false,
                },
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            },
            sources = cmp.config.sources({
                {
                    name = "nvim_lsp",
                    priority = 1000,
                    entry_filter = function(entry)
                        return cmp.lsp.CompletionItemKind.Snippet ~= entry:get_kind()
                    end
                }, {
                    name = "luasnip",
                    priority = 750,
                    max_item_count = 5
                }, {
                    name = "path",
                    priority = 500,
                    max_item_count = 5
                }, {
                    name = "buffer",
                    priority = 250,
                    max_item_count = 5
                }
            }),
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(entry, item)
                    local source_labels = {
                        nvim_lsp = "LSP",
                        luasnip  = "Snip",
                        buffer   = "Buf",
                        path     = "Path",
                    }
                    local icon, _, _ = icons.get("lsp", item.kind)
                    item.kind = (icon or "") .. " "
                    item.menu = source_labels[entry.source.name] or entry.source.name
                    if #item.abbr > 40 then
                        item.abbr = item.abbr:sub(1, 40) .. "…"
                    end
                    return item
                end,
            },
            experimental = {
                ghost_text = {
                    hl_group = "LspCodeLens",
                },
            },
        }
    end,
}
