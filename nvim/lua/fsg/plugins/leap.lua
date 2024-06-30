return {
  "ggandor/leap.nvim",
  lazy = false,
  dependencies = {
    "tpope/vim-repeat",
  },
  config = function()
    require('leap').create_default_mappings()
    -- Override some old defaults - use backspace instead of tab (see issue #165).
    require('leap').opts.special_keys.prev_target = '<backspace>'
    require('leap').opts.special_keys.prev_group = '<backspace>'
  end
}
