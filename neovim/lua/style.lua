vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.bo.softtabstop = 2

-- show line numbers
vim.wo.number = true
vim.o.cmdheight = 0

-- single status line
vim.opt.laststatus = 3

-- show trailing whitespace
vim.cmd.highlight('trailing_whitespace guibg=#ffdd00')
vim.cmd.match('trailing_whitespace /\\s\\+$/')
