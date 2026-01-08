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

function QFTF()
  local lines = {}
  for i, it in ipairs(vim.fn.getqflist()) do
    if it.valid == 1 and it.bufnr ~= 0 then
      local path = vim.api.nvim_buf_get_name(it.bufnr)
      path = string.gsub(path, vim.fn.getcwd() .. '/', '')
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
