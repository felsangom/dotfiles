--[[
-- Auto commands
--]]

-- Automatically remove all trailing whitespace
-- api.nvim_create_autocmd(
--   "BufWritePre",
--   {
--     pattern = "*",
--     command = "%s/\\s\\+$//e"
--   }
-- )

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.opt.foldmethod:get() == "expr" then
      vim.schedule(function()
        vim.opt.foldmethod = "expr"
      end)
    end
  end,
})
