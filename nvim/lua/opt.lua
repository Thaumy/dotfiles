local shorten_path = require 'infra.shorten_path'

vim.o.shortmess = 'ltToOcCFsSI'
vim.o.softtabstop = 2
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.fillchars = 'eob: '

-- extra characters in viw
vim.o.iskeyword = '@,48-57,_,192-255,-,#'

-- show line numbers
vim.o.number = true
vim.o.numberwidth = 1

-- single status line
vim.o.laststatus = 3

-- hl current line
vim.o.cursorline = true

-- share system clipboards
vim.o.clipboard = 'unnamed,unnamedplus'

-- disable swap file
vim.o.swapfile = false

-- disable line wrapping when esceeding term width
vim.o.wrap = false

-- keymap expire time
vim.o.timeoutlen = 500

-- disable deprecation warnings
vim.deprecate = function() end

-- providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_python3_provider = 0

-- max qflist stack size
vim.o.chi = 3

function QFTF(opts)
  local list = nil
  if opts.quickfix == 1 then
    list = vim.fn.getqflist()
  else
    list = vim.fn.getloclist(opts.wini)
  end

  local lines = {}

  for i, it in ipairs(list) do
    if it.valid == 1 and it.bufnr ~= 0 then
      local path = shorten_path(vim.api.nvim_buf_get_name(it.bufnr))
      local text = string.gsub(it.text, '^%s+', '')
      if it.type ~= '' then
        lines[i] = string.format('%s:%d:%d [%s] %s', path, it.lnum, it.col, it.type, text)
      else
        lines[i] = string.format('%s:%d:%d %s', path, it.lnum, it.col, text)
      end
    else
      lines[i] = it.text
    end
  end

  return lines
end

vim.o.qftf = 'v:lua.QFTF'
