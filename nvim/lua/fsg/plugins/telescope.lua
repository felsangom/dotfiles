return {
  "nvim-telescope/telescope.nvim",
  lazy = true,
  cmd = "Telescope",
  version = false,
  dependencies = {
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
  },
  config = function()
    require('telescope').setup({
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        sorting_strategy = "ascending",
        scroll_strategy = "limit",
        layout_config = {
          prompt_position = "top",
          preview_cutoff = 9999999999999
        }
      }
    })
    require('telescope').load_extension('fzf')
  end,
  keys = {
    -- find
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>ff", function() require('telescope.builtin').find_files({ hidden = true }) end, desc = "Find Files (root dir)" },
    { "<leader>fF", function() require('telescope.builtin').find_files({ hidden = true, cwd = false }) end, desc = "Find Files (cwd)" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
    -- search
    { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
    { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
    { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
    { "<leader>sg", function() require('telescope.builtin').live_grep() end, desc = "Grep (root dir)" },
    { "<leader>sG", function() require('telescope.builtin').live_grep({ cwd = false }) end, desc = "Grep (cwd)" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
    { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
    { "<leader>sr", "<cmd>Telescope resume<cr>", desc = "Resume" },
    { "<leader>sw", function() require('telescope.builtin').grep_string() end, desc = "Word (root dir)" },
    { "<leader>sW", function() require('telescope.builtin').grep_string({ cwd = false }) end, desc = "Word (cwd)" },
    {
      "<leader>ss",
      function()
        require('telescope.builtin').lsp_document_symbols({
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        })
      end,
      desc = "Goto Symbol",
    },
    {
      "<leader>sS",
      function()
        require('telescope.builtin').lsp_dynamic_workspace_symbols({
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        })
      end,
      desc = "Goto Symbol (Workspace)",
    },
  },
}
