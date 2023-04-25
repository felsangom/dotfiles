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

  -- better vim.ui
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },

  -- icons
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- plenary
  { "nvim-lua/plenary.nvim", lazy = true },

  -- ui components
  { "MunifTanjim/nui.nvim", lazy = true },
}
