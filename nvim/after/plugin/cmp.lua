-- Make sure you setup `cmp` after lsp-zero

local cmp = require('cmp')

cmp.setup({
  mapping = {
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete()
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' }
  }, {
    { name = 'buffer' }
  })
})
