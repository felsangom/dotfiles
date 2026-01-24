return {
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    opts = {
      enable_autocmd = false,
    }
  },
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "javascript",
        "json",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
        "java",
        "python",
        "toml",
        "gdscript"
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Pula automaticamente para o próximo objeto se não estiver sobre um
          keymaps = {
            -- Você pode usar 'a' (around) ou 'i' (inside)
            ["af"] = "@function.outer", -- Seleciona a função inteira
            ["if"] = "@function.inner", -- Seleciona o conteúdo da função
            ["ac"] = "@class.outer",    -- Seleciona a classe inteira
            ["ic"] = "@class.inner",    -- Seleciona o conteúdo da classe
            ["aa"] = "@parameter.outer", -- Seleciona um argumento/parâmetro
            ["ia"] = "@parameter.inner", -- Seleciona só o texto do argumento
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- Adiciona à jumplist (pode voltar com C-o)
          goto_next_start = {
            ["]m"] = "@function.outer", -- Vai para o início da próxima função
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer", -- Vai para o fim da próxima função
          },
          goto_previous_start = {
            ["[m"] = "@function.outer", -- Volta para o início da função anterior
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
          },
        },
      },
    },
    ---@param opts TSConfig
    config = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        ---@type table<string, boolean>
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
