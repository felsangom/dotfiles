--[[
-- Auto commands
--]]

local function augroup(name)
  return vim.api.nvim_create_augroup("fsg_" .. name, { clear = true })
end

-- 1. Highlight on Yank (Essencial!)
-- Dá um feedback visual rápido piscando o texto que você copiou (y).
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank({ timeout = 200 }) -- Pisca por 200ms
  end,
})

-- 2. Resize Splits automaticamente
-- Se você redimensionar a janela do terminal, o Neovim reajusta os splits para ficarem iguais.
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- 3. Notificação discreta ao salvar arquivo
vim.api.nvim_create_autocmd("BufWritePost", {
    group = augroup("notify_save"),
    callback = function()
        local fname = vim.fn.expand("%:t")
        if fname ~= "" then
            vim.notify(fname .. " salvo", vim.log.levels.INFO)
        end
    end,
})

-- 4. Abrir Help sempre na vertical (Opcional, mas muito bom)
-- Por padrão o help abre na horizontal e ocupa metade da tela.
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("help_window"),
  pattern = "help",
  callback = function()
    vim.bo.bufhidden = "unload"
    vim.cmd.wincmd("L") -- Move para a direita (Vertical Split)
    vim.cmd.wincmd("=") -- Balanceia o tamanho
  end,
})
