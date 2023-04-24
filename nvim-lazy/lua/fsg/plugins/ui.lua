return {
  --[[
  -- Lualine
  --]]
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "kanagawa",
        icons_enabled = true,
        globalstatus = true
      },
      tabline = {}
    }
  },

  -- icons
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- plenary
  { "nvim-lua/plenary.nvim", lazy = true },

  -- ui components
  { "MunifTanjim/nui.nvim", lazy = true },
}
