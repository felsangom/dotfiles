return {
    "ggandor/leap.nvim",
    lazy = false,
    dependencies = {
        "tpope/vim-repeat",
    },
    config = function()
        local leap = require('leap')
        leap.opts.special_keys.prev_target = '<backspace>'
        leap.opts.special_keys.prev_group = '<backspace>'

        vim.keymap.set({'n', 'x', 'o'}, 's',  '<Plug>(leap-forward)')
        vim.keymap.set({'n', 'x', 'o'}, 'S',  '<Plug>(leap-backward)')
        vim.keymap.set({'n', 'x', 'o'}, 'gs', '<Plug>(leap-from-window)')
    end
}
