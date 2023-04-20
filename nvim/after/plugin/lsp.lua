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

local icons = {
  diagnostics = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " ",
    Information = " ",
  }
}

for name, icon in pairs(icons.diagnostics) do
  name = "DiagnosticSign" .. name
  vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
end
