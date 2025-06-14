print("Greeting, my lord!")
vim.o.relativenumber=true
vim.opt.termguicolors = true
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
require("config.lazy")
require("keymaps")
require("base")
vim.cmd('colorscheme nord')

