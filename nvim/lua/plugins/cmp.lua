return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter", -- chỉ load khi vào Insert mode (tăng tốc khởi động)
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",     -- Gợi ý từ LSP
      "hrsh7th/cmp-buffer",       -- Gợi ý từ nội dung buffer
      "hrsh7th/cmp-path",         -- Gợi ý đường dẫn file
      "saadparwaiz1/cmp_luasnip", -- Gợi ý từ snippet
      "L3MON4D3/LuaSnip",         -- Snippet engine
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end
  }
}

