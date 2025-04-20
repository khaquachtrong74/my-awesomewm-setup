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
                default_component_configs = {
                    icon = {
                      folder_closed = "🗀",
                      folder_open = "🗁",
                      folder_empty = "🫙",
                      default = "🗀",
                      highlight = "NeoTreeFileIcon",
                    },
                }
            })
        end,
        lazy = false,
    },
}
