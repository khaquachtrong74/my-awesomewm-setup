return{
    { 'nvim-tree/nvim-tree.lua'},
    { 'nvim-neo-tree/neo-tree.nvim',
        branch = 'v3.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'MunifTanjim/nui.nvim',
            'nvim-tree/nvim-web-devicons',
        },
        -- @module 'neotree'
        -- @type  neotree.Config?
        config = function ()
            require('neo-tree').setup({
                
            })
        end,
        lazy = false,
    },
}
