return {
  'nvim-tree/nvim-tree.lua',
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
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
    },
    view = {
      adaptive_size = true
    }
  },
  config = function(_, opts)
    require('nvim-tree').setup(opts)
  end
}
