return{
    {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
        require('kanagawa').setup({
        compile = false,
        undercurl = true,
        commentStyle = { italic = true },
        functionStyle = { bold = true },
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = { bold = true },
        transparent = false, -- bạn muốn xuyên nền thì bật true
        terminalColors = true,
      })
    end
    },
    {
      "projekt0n/github-nvim-theme",
      priority = 1000,
      config = function()
        require('github-theme').setup({
        })
      end
    },
    { 'nvim-lualine/lualine.nvim',
        config = function()
            require('lualine').setup {
              options = {
                icons_enabled = true,
                theme = 'auto',
                component_separators = { left = '', right = ''},
                section_separators = { left = '', right = ''},
                disabled_filetypes = {
                  statusline = {},
                  winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                always_show_tabline = true,
                globalstatus = false,
                refresh = {
                  statusline = 100,
                  tabline = 100,
                  winbar = 100,
                }
              },
              sections = {
                lualine_a = {'mode'},
                lualine_b = {'branch', 'diff', 'diagnostics'},
                lualine_c = {'filename'},
                lualine_x = {'encoding', 'fileformat', 'filetype'},
                lualine_y = {'progress'},
                lualine_z = {'location'}
              },
              inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {'filename'},
                lualine_x = {'location'},
                lualine_y = {},
                lualine_z = {}
              },
              tabline = {},
              winbar = {},
              inactive_winbar = {},
              extensions = {}
            }

        end
    },
    { 'folke/tokyonight.nvim',
        config = function()
        --      vim.cmd('colorscheme tokyonight')
        end
    },

}
