return {
    {
        'barrett-ruth/import-cost.nvim',
        build = 'sh install.sh yarn',
        -- if on windows
        -- build = 'pwsh install.ps1 yarn',
        config = function()
            require('import-cost').setup({
                filetypes = {
                    'javascript',
                    'javascriptreact',
                    'typescript',
                    'typescriptreact',
                },
                format = {
                    byte_format = '%.1fb',
                    kb_format = '%.1fk',
                    virtual_text = '%s (gzipped: %s)',
                },
                highlight = 'Comment',
            })
        end
    },
}
