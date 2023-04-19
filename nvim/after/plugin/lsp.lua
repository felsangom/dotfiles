require('mason').setup()

require('mason-lspconfig').setup({
  ensure_installed = {
    'html',
    'emmet_ls',
    'tsserver',
  }
})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

local lspconfig = require('lspconfig')
require('mason-lspconfig').setup_handlers({
  function(server_name)
    lspconfig[server_name].setup({
      capabilities = lsp_capabilities
    })
  end
})

local signs = {
  Error = " ",
  Warning = " ",
  Hint = " ",
  Information = " "
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
