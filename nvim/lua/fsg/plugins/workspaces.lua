return {
    'natecraddock/workspaces.nvim',
    dependencies = {
        'natecraddock/sessions.nvim'
    },
    opts = {
        hooks = {
            open_pre = {
                "SessionsSave .nvim_session",
                "silent %bdelete!",
            },
            open = {
                'SessionsLoad .nvim_session'
            }
        }
    },
    config = function(_, opts)
        require('workspaces').setup(opts)
    end
}
