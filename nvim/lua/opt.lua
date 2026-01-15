local shorten_path = require 'infra.shorten_path'

vim.go.shortmess = 'ltToOcCFsSI'
vim.go.softtabstop = 2
vim.go.tabstop = 2
vim.go.shiftwidth = 2
vim.go.expandtab = true
vim.go.fillchars = 'eob: '

-- extra characters in viw
vim.go.iskeyword = '@,48-57,_,192-255,-,#'

-- show line numbers
vim.go.number = true
vim.go.numberwidth = 1

-- single status line
vim.go.laststatus = 3

-- hl current line
vim.go.cursorline = true

-- share system clipboards
vim.go.clipboard = 'unnamed,unnamedplus'

-- disable swap file
vim.go.swapfile = false

-- disable line wrapping when esceeding term width
vim.go.wrap = false

-- keymap expire time
vim.go.timeoutlen = 500

-- disable deprecation warnings
vim.deprecate = function() end

-- providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_python3_provider = 0

-- max qflist stack size
vim.go.chi = 3

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

vim.go.qftf = 'v:lua.QFTF'
