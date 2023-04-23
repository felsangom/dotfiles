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

local noice_hl = vim.api.nvim_create_augroup("NoiceHighlights", {})
local noice_cmd_types = {
  CmdLine = "Constant",
  Input = "Constant",
  Calculator = "Constant",
  Lua = "Constant",
  Filter = "Constant",
  Rename = "Constant",
  Substitute = "NoiceCmdlinePopupBorderSearch",
  Help = "helpVim",
}
vim.api.nvim_clear_autocmds({ group = noice_hl })
vim.api.nvim_create_autocmd("BufEnter", {
  group = noice_hl,
  desc = "redefinition of noice highlight groups",
  callback = function()
    for type, hl in pairs(noice_cmd_types) do
      vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder" .. type, {})
      vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder" .. type, { link = hl })
    end
    vim.api.nvim_set_hl(0, "NoiceConfirmBorder", {})
    vim.api.nvim_set_hl(0, "NoiceConfirmBorder", { link = "Constant" })
  end,
})
