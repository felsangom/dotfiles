local function augroup(name)
    return vim.api.nvim_create_augroup("fsg_" .. name, { clear = true })
end

-- 1. Highlight on Yank
-- Dá um feedback visual rápido piscando o texto ao copiar
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function()
        vim.hl.on_yank({ timeout = 200 })
    end,
})

-- 2. Resize Splits automaticamente
-- Se redimensionar a janela do terminal, o Neovim reajusta os splits para ficarem iguais.
vim.api.nvim_create_autocmd({ "VimResized" }, {
    group = augroup("resize_splits"),
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. current_tab)
    end,
})

-- 3. Smart Whitespace Stripper
-- Remove espaços, mas protege Markdown e não roda em arquivos binários
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = augroup("trim_whitespace"),
    pattern = "*",
    callback = function()
        -- Lista de exclusão (Blacklist)
        local ignore_filetypes = { "markdown", "text", "binary" }
        if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
            return
        end

        -- Salva a posição do cursor para não pular pro começo
        local save_cursor = vim.fn.getpos(".")
        pcall(function() vim.cmd [[%s/\s\+$//e]] end)
        vim.fn.setpos(".", save_cursor)
    end,
})

-- 4. Abrir Help sempre na vertical
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("help_window"),
    pattern = "help",
    callback = function()
        vim.bo.bufhidden = "unload"
        vim.cmd.wincmd("L") -- Move para a direita (Vertical Split)
        vim.cmd.wincmd("=") -- Balanceia o tamanho
    end,
})

-- 5 - Organizar imports Python ao salvar usando Ruff
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.py",
    callback = function()
        vim.lsp.buf.code_action({
            context = { only = { "source.organizeImports" } },
            apply = true,
        })
        -- O format normal já roda pelo seu keymap ou outro autocmd se tiver
    end,
})
