local shorten_path = require 'infra.shorten_path'

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
