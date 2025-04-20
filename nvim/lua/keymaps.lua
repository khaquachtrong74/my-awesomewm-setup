-- format
-- vim.keymap.set({mode}, lhs, rhs, opts)
-- lhs : `tổ hợp bàn phím`,
-- rhs : `hành động thực thi`,
-- opts: `bảng tuỳ chọn {silent, noremap, desc}`
local k = vim.keycode
-- NORMAL -- 
vim.keymap.set("n","<TAB>", "<cmd>Neotree toggle<CR>", {desc = "Neotree toggle", silent=true})
vim.keymap.set("n","<C-s>",function()
vim.cmd("w")
print("✅Save success, Good job!")
end,{
desc = "Save & cheer",
silent = true
})
vim.keymap.set("n", "<C-q>","<cmd>q<CR>",{desc = "Quit",silent=true})
-- telescope setting map
vim.keymap.set("n", "<leader>d","<cmd>Telescope current_buffer_fuzzy_find<CR>",{desc = "Fuzzy search in current file"})
vim.keymap.set("n", "<leader>f", function()
    require("telescope.builtin").find_files({
        cmd = vim.fn.expand("%:p:h"),
    })
end, {desc = "Find file in current folder"})
