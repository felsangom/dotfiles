local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      require'luasnip'.lsp_expand(args.body)
    end
  },
  mapping = {
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({select = false}),
    -- Tab, Shift + Tab to cycle through list
    ['<Tab>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_next_item()
      end
    end),
    ['<S-Tab>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      end
    end),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete()
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }
  }, {
    { name = 'buffer' },
    { name = 'path' }
  })
})
