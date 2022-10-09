--[[
-- Telescope configs
--]]

require("telescope").setup({
  defaults = {
    sorting_strategy = "ascending",
    scroll_strategy = "limit",
    layout_config = {
      prompt_position = "top"
    }
  }
})

