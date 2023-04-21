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

