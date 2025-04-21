vim.opt.tabstop = 2
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.mouse = "a" 
vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus" 
vim.opt.breakindent = true 
vim.opt.undofile = true 
vim.opt.signcolumn = "yes" 
vim.opt.cursorline = true
vim.opt.guifont = { "JetBrainsMono Nerd Font", ":h12"}
vim.api.nvim_create_autocmd("TextYankPost",{
    desc = "Highlight when yanking (copying) text",
    callback = function()
        vim.highlight.on_yank()
    end,
})
vim.o.relativenumber = true

-- SETTING FOR STATUS LINE 
local modes = {
    ["n"] = "NORMAL",
    ["no"]= "NORMAL",
    ["v"] = "VISUAL",
    ["V"] = "VISUAL LINE",
    [""]  = "VISUAL BLOCK",
    ["s"] = "SELECT",
    ["S"] = "SELECT LINE",
    [""]  = "SELECT BLOCK",
    ["i"] = "INSERT",
    ["ic"] = "INSERT",
    ["R"] = "REPLACE",
    ["Rv"] = "VISUAL REPLACE",
    ["c"] = "COMMAND",
    ["cv"] = "VIM EX",
    ["ce"] = "EX",
    ["r"] = "PROMPT",
    ["rm"] = "MOAR",
    ["r?"] = "CONFIRM",
    ["!"] = "SHELL",
    ["t"] = "TERMINAL",
}
