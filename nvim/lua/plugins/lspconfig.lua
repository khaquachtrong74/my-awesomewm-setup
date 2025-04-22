return {
  -- LSP support
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim", build = ":MasonUpdate", config = function() require("mason").setup() end },
  { "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "clangd", "lua_ls", "gopls" }
      })
      local lspconfig = require("lspconfig")
      lspconfig.clangd.setup({
		require("cmp_nvim_lsp").default_capabilities(),
      })
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } }
          }
        }
      })
      lspconfig.gopls.setup({})
    end
  },
  -- Completion
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" }
}

