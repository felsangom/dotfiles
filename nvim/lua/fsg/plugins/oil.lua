return {
  'stevearc/oil.nvim',
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    default_file_explorer = true,
    columns = {
      "icon",
    },
    float = {
      padding = 4,
      max_width = 100
    }
  },
  config = function(_, opts)
    require('oil').setup(opts)
  end
}
