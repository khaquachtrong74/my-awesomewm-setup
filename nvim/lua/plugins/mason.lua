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
                    "clangd", -- for c++/c 
                    "lua_ls", -- for lua 
--                    "cmake",
                    "gopls", -- for golang
                    "pyright", -- for python
                    "ts_ls", --type-script: for nodejs
                    "html"
                }
            }
            local lspconfig = require("lspconfig")
              lspconfig.clangd.setup({})
              lspconfig.lua_ls.setup({})
 --             lspconfig.cmake.setup({})
             lspconfig.ts_ls.setup({})
             lspconfig.html.setup({})
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
