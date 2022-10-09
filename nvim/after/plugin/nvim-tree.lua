--[[
-- Nvim-tree configs
--]]

vim.g.loaded = true
vim.g.loaded_netrwPluggin = true

require("nvim-tree").setup({
  disable_netrw = true,
  reload_on_bufenter = true,
  respect_buf_cwd = true,
  hijack_cursor = true,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = true,
  renderer = {
    indent_markers = {
      enable = true
    }
  },
  actions = {
    open_file = {
      quit_on_open = true
    }
  }
})
