return {
  --[[
  -- Lualine
  --]]
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "tokyonight",
        icons_enabled = true,
        globalstatus = true,
        section_separators = { left = '', right = '' },
        component_separators = '|'
      },
      sections = {
        lualine_a = {
          { 'mode', separator = { right = '' }, right_padding = 2 },
        }
      },
      tabline = {}
    }
  },

  -- BarBar
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
      auto_hide = 1,
      no_name_title = 'Sem nome'
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
    opts = {
      input = {
        win_options = {
          winblend = 0
        }
      },
      select = {
        win_options = {
          winblend = 0
        }
      }
    }
  },

  -- icons
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- plenary
  { "nvim-lua/plenary.nvim", lazy = true },

  -- ui components
  { "MunifTanjim/nui.nvim", lazy = true },
}
