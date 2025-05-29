return{
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup{
                ensure_installed = {
                    "clangd",
                    "lua_ls",
                    "cmake",
                    "gopls",
                    "pyright"
                }
            }
            local lspconfig = require("lspconfig")
              lspconfig.clangd.setup({})
              lspconfig.lua_ls.setup({})
              lspconfig.cmake.setup({})
              lspconfig.gopls.setup({})
              lspconfig.pyright.setup({})
            require("lspconfig").lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = {"vim"}
                        },
                    },
                },
            })
        end
    },
    
}
