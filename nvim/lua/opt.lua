local vim_o = vim.o
local vim_g = vim.g
local vim_fn = vim.fn
local string_gsub = string.gsub
local shorten_path = require 'infra.shorten_path'
local string_format = string.format
local nvim_buf_get_name = vim.api.nvim_buf_get_name

vim_o.shortmess = 'ltToOcCFsSI'
vim_o.softtabstop = 2
vim_o.tabstop = 2
vim_o.shiftwidth = 2
vim_o.expandtab = true
vim_o.fillchars = 'eob: '
vim_o.numberwidth = 1

if VVP_MODE then
  vim_o.number = false
  vim_o.laststatus = 0
  vim_o.cmdheight = 0
else
  -- show line numbers
  vim_o.number = true
  -- single status line
  vim_o.laststatus = 3
end

-- disable key presses and selected area printing
vim_o.showcmd = false

-- disable mode printing
vim_o.showmode = false

-- extra characters in viw
vim_o.iskeyword = '@,48-57,_,192-255,-,#'

-- hl current line
vim_o.cursorline = true

-- share system clipboards
vim_o.clipboard = 'unnamed,unnamedplus'

-- disable swap file
vim_o.swapfile = false

-- disable line wrapping when exceeds term width
vim_o.wrap = false

-- keymap expire time
vim_o.timeoutlen = 500

-- disable deprecation warnings
vim.deprecate = function() end

-- providers
vim_g.loaded_perl_provider = 0
vim_g.loaded_node_provider = 0
vim_g.loaded_ruby_provider = 0
vim_g.loaded_python3_provider = 0

-- max qflist stack size
vim_o.chi = 3

function QFTF(opts)
  local list
  if opts.quickfix == 1 then
    list = vim_fn.getqflist()
  else
    list = vim_fn.getloclist(opts.wini)
  end

  local lines = {}

  for i, it in ipairs(list) do
    if it.valid == 1 and it.bufnr ~= 0 then
      local path = shorten_path(nvim_buf_get_name(it.bufnr))
      local text = string_gsub(it.text, '^%s+', '')
      if it.type ~= '' then
        lines[i] = string_format('%s:%d:%d [%s] %s', path, it.lnum, it.col, it.type, text)
      else
        lines[i] = string_format('%s:%d:%d %s', path, it.lnum, it.col, text)
      end
    else
      lines[i] = it.text
    end
  end

  return lines
end

vim_o.qftf = 'v:lua.QFTF'
