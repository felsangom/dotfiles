--[[
-- Auto commands
--]]

local api = vim.api

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
    pattern = 'typescript,json',
    command = "setl formatexpr=CocAction('formatSelected')"
  }
)

-- Signature help on jump placeholder
api.nvim_create_autocmd(
  "User",
  {
    pattern = 'CocJumpPlaceholder',
    command = "call CocActionAsync('showSignatureHelp')"
  }
)

-- Highlight symbol under cursor on CursorHold
api.nvim_create_autocmd(
  "CursorHold",
  {
    pattern = '*',
    command = "silent call CocActionAsync('highlight')"
  }
)
