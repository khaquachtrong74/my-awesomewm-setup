-- ~/.config/nvim/lua/plugins/telescope.lua

return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" }, -- Ensure plenary is installed
    config = function()
    require('telescope').setup{
      defaults = {
        -- Configure your defaults here
        prompt_position = "top",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
           layout_config = {
            prompt_position = "top",
        },
        sorting_stategy = "ascending",
        windblend = 0,
        },
        pickers = {
            current_buffer_fuzzy_find = {
                theme = "dropdown",
                previewer = false,
            },
        },
    }
  end
}

