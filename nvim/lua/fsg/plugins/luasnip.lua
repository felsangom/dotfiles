return {
  "L3MON4D3/LuaSnip",
  build = "make install_jsregexp",
  lazy = true,
  dependencies = {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load({
        exclude = {
          "ruby"
        }
      })
    end,
  },
  opts = {
    history = true,
    delete_check_events = {"InsertEnter"},
    region_check_events = {"InsertLeave", "InsertEnter"}
  }
}
