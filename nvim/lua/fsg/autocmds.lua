--[[
-- Auto commands
--]]

local api = vim.api
local coc_group = vim.api.nvim_create_augroup("coc_group", { clear = true})

-- Automatically remove all trailing whitespace
api.nvim_create_autocmd(
  "BufWritePre",
  {
    pattern = "*",
    command = "%s/\\s\\+$//e"
  }
)

--[[
-- If you like code folding, uncomment the autocmd bellow
-- Autocmd according to https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation
--]]
--[[
vim.api.nvim_create_autocmd(
  {'BufEnter','BufAdd','BufNew','BufNewFile','BufWinEnter'},
  {
    group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
    callback = function()
      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
    end
  }
)
--]]
