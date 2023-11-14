local home_dir = "/home/felipe"

-- pin nvim to a specific node version, regardless of the project
-- prereq - need to install: nvm i 16.17.1
local node_bin =  "/.nvm/versions/node/v18.16.1/bin"
-- vim.g.node_host_prog = home_dir .. node_bin .. "/node"

-- for mason.nvim
-- prereq - install lsp server in that node/bin npm i -g typescript-language-server 
-- (handled by :Mason currently)
vim.cmd("let $PATH = '" .. home_dir .. node_bin .. ":' . $PATH")
