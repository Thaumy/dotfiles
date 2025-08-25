local ffi = require 'ffi'
local map = require 'infra.key'.map

map('n', 'vb', function()
  local str      = vim.api.nvim_get_current_line()
  local line     = ffi.cast('int8_t*', str)

  local pos      = vim.api.nvim_win_get_cursor(0)
  local col      = ffi.new('size_t', pos[2])

  local sel_from = ffi.new 'size_t[1]'
  local sel_to   = ffi.new 'size_t[1]'

  if LIBNVIMCFG.visual_block(line, col, sel_from, sel_to) then
    vim.api.nvim_win_set_cursor(0, { pos[1], tonumber(sel_from[0]) })
    vim.cmd [[execute "normal! \v"]]
    vim.api.nvim_win_set_cursor(0, { pos[1], tonumber(sel_to[0]) })
  end
end)
