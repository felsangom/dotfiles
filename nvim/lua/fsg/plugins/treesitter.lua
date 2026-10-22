local parsers = {
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
  "gdscript",
}

return {
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    opts = {
      enable_autocmd = false,
    }
  },
  {
    -- Branch `main`: reescrita incompatível, exige Nvim 0.12+ e não suporta lazy-load.
    -- Só instala parsers/queries; highlight, fold e seleção são recursos nativos do Nvim.
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    version = false,
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")
      ts.install(parsers) -- assíncrono; no-op para o que já está instalado

      -- Substitui o antigo `auto_install = true`: instala o parser de qualquer
      -- filetype suportado na primeira vez que ele é aberto.
      local function start(buf, lang)
        if not vim.api.nvim_buf_is_valid(buf) or not pcall(vim.treesitter.start, buf, lang) then
          return
        end
        if vim.treesitter.query.get(lang, "indents") then
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("fsg_treesitter", { clear = true }),
        callback = function(ev)
          local lang = vim.treesitter.language.get_lang(ev.match)
          if not lang then
            return
          end
          if vim.list_contains(ts.get_installed(), lang) then
            start(ev.buf, lang)
          elseif vim.list_contains(ts.get_available(), lang) then
            ts.install(lang):await(function()
              vim.schedule(function() start(ev.buf, lang) end)
            end)
          end
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    lazy = false,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    init = function()
      -- O ftplugin de python define ]] [[ ]m [m buffer-local e sobrescreveria os mapas abaixo.
      vim.g.no_python_maps = true
    end,
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = { lookahead = true },
        move = { set_jumps = true },
      })

      local map = vim.keymap.set
      local select = require("nvim-treesitter-textobjects.select").select_textobject
      local move = require("nvim-treesitter-textobjects.move")

      -- Você pode usar 'a' (around) ou 'i' (inside)
      local objects = {
        af = "@function.outer",  -- Seleciona a função inteira
        ["if"] = "@function.inner", -- Seleciona o conteúdo da função
        ac = "@class.outer",     -- Seleciona a classe inteira
        ic = "@class.inner",     -- Seleciona o conteúdo da classe
        aa = "@parameter.outer", -- Seleciona um argumento/parâmetro
        ia = "@parameter.inner", -- Seleciona só o texto do argumento
      }
      for lhs, query in pairs(objects) do
        map({ "x", "o" }, lhs, function() select(query, "textobjects") end, { desc = "TS " .. query })
      end

      local moves = {
        { "]m", "goto_next_start", "@function.outer" },     -- Início da próxima função
        { "]]", "goto_next_start", "@class.outer" },
        { "]M", "goto_next_end", "@function.outer" },       -- Fim da próxima função
        { "[m", "goto_previous_start", "@function.outer" }, -- Início da função anterior
        { "[[", "goto_previous_start", "@class.outer" },
        { "[M", "goto_previous_end", "@function.outer" },
      }
      for _, m in ipairs(moves) do
        map({ "n", "x", "o" }, m[1], function() move[m[2]](m[3], "textobjects") end, { desc = "TS " .. m[3] })
      end

      -- Seleção incremental: nativa na 0.12 (v_an / v_in)
      map("n", "<C-space>", "van", { remap = true, desc = "Incremental selection" })
      map("x", "<C-space>", "an", { remap = true, desc = "Expand selection" })
      map("x", "<bs>", "in", { remap = true, desc = "Shrink selection" })
    end,
  },
}
