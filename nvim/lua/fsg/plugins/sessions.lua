return {
    'natecraddock/sessions.nvim',
    opts = {},
    config = function(_, opts)
        require('sessions').setup(opts)
    end
}
