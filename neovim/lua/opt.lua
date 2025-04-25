vim.o.shortmess = 'ltToOcCFsSI'
vim.bo.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.fillchars:append { eob = ' ' }

-- extra characters in viw
vim.opt.iskeyword:append { '-', '#' }

-- show line numbers
vim.wo.number = true
vim.opt.numberwidth = 1

-- single status line
vim.opt.laststatus = 3

-- hl current line
vim.opt.cursorline = true

-- share system clipboards
vim.opt.clipboard = 'unnamed,unnamedplus'

-- disable swap file
vim.opt.swapfile = false

-- disable line wrapping when esceeding term width
vim.wo.wrap = false

-- keymap expire time
vim.o.timeoutlen = 500

-- disable deprecation warnings
vim.deprecate = function() end

-- providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_python3_provider = 0
