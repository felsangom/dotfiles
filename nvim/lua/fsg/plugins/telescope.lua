return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  version = false,
  dependencies = {
    { 'nvim-treesitter/nvim-treesitter' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-telescope/telescope-ui-select.nvim' },
  },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')

    telescope.setup({
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "filename_first" },
        -- Otimização de Performance
        file_ignore_patterns = { "node_modules", ".git/", "target/", "build/", "%.class" },
        -- Proteção contra arquivos gigantes (Logs, Dumps)
        preview = {
            filesize_limit = 0.1, -- MB
        },
        sorting_strategy = "ascending",
        layout_strategy = "vertical",
        layout_config = {
            vertical = {
                prompt_position = "top",
                mirror = true,
                width = 0.85,
                height = 0.90,
                preview_height = 0.45,
            }
        },
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-d>"] = actions.delete_buffer,
            },
            n = {
                ["q"] = actions.close,
                ["<C-d>"] = actions.delete_buffer,
            }
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {
          }
        }
      }
    })

    -- Carrega as extensões
    telescope.load_extension('fzf')
    telescope.load_extension('ui-select')
  end,
  keys = {
    -- find
    { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Find buffer" },
    { "<leader>ff", function() require('telescope.builtin').find_files({ hidden = true }) end, desc = "Find Files (root dir)" },
    { "<leader>fF", function() require('telescope.builtin').find_files({ hidden = true, no_ignore = true }) end, desc = "Find ALL Files (inc. gitignore)" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },

    -- search
    { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search buffer" },
    { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
    { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
    { "<leader>sg", function() require('telescope.builtin').live_grep() end, desc = "Grep (Root)" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
    { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Marks" },
    { "<leader>sr", "<cmd>Telescope resume<cr>", desc = "Resume" },
    { "<leader>sw", function() require('telescope.builtin').grep_string() end, desc = "Word under cursor" },

    -- Symbols
    {
      "<leader>ss",
      function()
        require('telescope.builtin').lsp_document_symbols({
          symbols = { "Class", "Function", "Method", "Constructor", "Interface", "Module", "Struct", "Trait", "Field", "Property" },
        })
      end,
      desc = "Goto Symbol",
    },
    {
      "<leader>sS",
      function()
        require('telescope.builtin').lsp_dynamic_workspace_symbols({
          symbols = { "Class", "Function", "Method", "Constructor", "Interface", "Module", "Struct", "Trait", "Field", "Property" },
        })
      end,
      desc = "Goto Symbol (Workspace)",
    },
  },
}
