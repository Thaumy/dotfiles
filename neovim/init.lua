require 'keymap'
require 'cmd'
require 'lsp'
require 'plugin/mod'

vim.filetype.add({
  extension = {
    typ = 'typst'
  }
})

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

-- share system clipboards
vim.opt.clipboard = 'unnamed,unnamedplus'

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- disable swap file
vim.opt.swapfile = false
