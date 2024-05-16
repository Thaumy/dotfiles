local plugin = require 'ufo'
local k = require 'infra.keymap'

vim.o.foldcolumn = '0' -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

plugin.setup()

-- nvim-ufo:
-- fold code block
k.map('n', '<M-k>', 'za')
-- expand code block
k.map('n', '<M-j>', 'zo')
