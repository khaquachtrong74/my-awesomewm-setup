return{
	{ "nvim-telescope/telescope.nvim", 
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            buid = "make",
            cond = function()
                return vim.fn.executable("make") ==1 
            end,
        },
    },
    require("telescope").setup({
        defaults = {
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
    })
  },
}
