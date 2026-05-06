-- Pega o diretório home dinamicamente (Funciona em Linux e macOS)
local home = vim.env.HOME
local node_version = "v22.16.0"
-- Constrói o caminho de forma limpa
local node_path = home .. "/.nvm/versions/node/" .. node_version .. "/bin"

-- Verifica se o diretório realmente existe para evitar erros silenciosos
if vim.fn.isdirectory(node_path) == 1 then
  -- Adiciona ao PATH usando a API nativa de Lua
  -- Isso afeta o Neovim e qualquer terminal/subprocesso aberto por ele
  vim.env.PATH = node_path .. ":" .. vim.env.PATH
else
  -- Opcional: Avisa se a versão pinada não for encontrada
  vim.notify("Node version " .. node_version .. " not found! Check fsg/node.lua", vim.log.levels.WARN)
end

-- Mantém comentado. Só é necessário para plugins legados que usam o 'remote plugin host'.
-- Hoje em dia, a maioria das ferramentas usa o PATH diretamente.
-- vim.g.node_host_prog = node_path .. "/node"
