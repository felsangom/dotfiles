--[[
Basic neovim configs
--]]

local g = vim.g
local o = vim.opt

-- Mapeamentos de líder devem ser definidos no init.lua antes de tudo, 
-- mas reforçar aqui não faz mal.
g.mapleader = ' '
g.maplocalleader = ' '

-- --- COMPORTAMENTO GERAL ---
o.confirm = true -- Pergunta se quer salvar ao sair com mudanças (Rede de segurança)
o.completeopt = "menu,menuone,noselect"
o.formatoptions = "jqlnt"
o.swapfile = false
o.clipboard = "unnamedplus" -- Sincroniza com clipboard do sistema
o.mouse = "a" -- Habilita mouse em todos os modos
o.undofile = true
o.ignorecase = true
o.smartcase = true
o.incsearch = true
o.hlsearch = false

-- --- UI & VISUAL ---
o.termguicolors = true
o.laststatus = 3
o.showmode = false
o.list = true
o.listchars:append "tab:» ,space:·,trail:·,eol:¬"
o.scrolloff = 8
o.signcolumn = "yes"
o.cursorline = true
o.splitbelow = true
o.splitright = true
o.shortmess:append({ W = true, I = true, c = true, s = true, C = true })

-- --- IDENTAÇÃO ---
o.expandtab = true
o.smarttab = true
o.tabstop = 4
o.shiftwidth = 4
o.number = true
o.relativenumber = true
o.wrap = false

-- --- PERFORMANCE & TIMING ---
o.updatetime = 250
-- o.timeoutlen = 300 -- Se sentir que os atalhos compostos demoram para registrar

-- --- FOLDING (MODERNIZADO) ---
o.fillchars:append({ fold = " " })
o.foldlevel = 99
o.foldenable = false
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- --- PROVIDERS & PLUGINS ---
-- Python dinâmico (Resolve o problema do hardcode)
local home = vim.env.HOME
local python_path = home .. "/Python/venv/bin/python3"
if vim.fn.filereadable(python_path) == 1 then
    g.python3_host_prog = python_path
end

-- Desativa providers desnecessários para startup mais rápido
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- Desativa netrw (Padrão para quem usa nvim-tree ou neo-tree)
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- Outras configurações específicas
g.skip_ts_context_commentstring_module = true
g.pyindent_open_paren = 0
g.pyindent_close_paren = 0
