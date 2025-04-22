return{
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdowPreviewStop"},
    build = "cd app && npm install",
    init = function()
        vim.g.mkdp_filetypes = {"markdown"}
        vim.g.mkdp_start = 0
        vim.gmkdp_close = 1
    end,
    ft = {"markdown"},
}
