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

-- formatexpr on specified file types
api.nvim_create_autocmd(
  "FileType",
  {
    group = coc_group,
    pattern = 'typescript,json',
    command = "setl formatexpr=CocAction('formatSelected')"
  }
)

-- Signature help on jump placeholder
api.nvim_create_autocmd(
  "User",
  {
    group = coc_group,
    pattern = 'CocJumpPlaceholder',
    command = "call CocActionAsync('showSignatureHelp')"
  }
)

-- Highlight symbol under cursor on CursorHold
api.nvim_create_autocmd(
  "CursorHold",
  {
    group = coc_group,
    pattern = '*',
    command = "silent call CocActionAsync('highlight')"
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
