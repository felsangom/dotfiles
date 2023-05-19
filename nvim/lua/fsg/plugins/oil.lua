return {
  'stevearc/oil.nvim',
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function(_, opts)
    require('oil').setup(opts)
  end
}
