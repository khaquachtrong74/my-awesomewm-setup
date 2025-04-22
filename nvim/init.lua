print("Greeting, my lord!")
vim.o.relativenumber=true

vim.opt.termguicolors = true
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")
require("keymaps")
require("base")

