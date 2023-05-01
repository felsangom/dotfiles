return {
  "L3MON4D3/LuaSnip",
  build = "make install_jsregexp",
  dependencies = {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require'luasnip'.filetype_extend("ruby", {"rails"})
    end,
  },
  opts = {
    history = true,
    delete_check_events = {"TextChanged", "InsertEnter"},
    region_check_events = {"TextChangedI", "CursorMoved", "InsertLeave", "InsertEnter"}
  }
}
