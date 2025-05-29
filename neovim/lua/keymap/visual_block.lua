local ffi = require 'ffi'
local map = require 'infra.key'.map

ffi.cdef [[
  bool visual_block(uint8_t* line, uint32_t col, uint32_t* sel_from, uint32_t* sel_to);
]]

local lib = ffi.load((os.getenv 'HOME') .. '/.config/libnvimcfg.so')

map('n', 'vb', function()
  local str      = vim.api.nvim_get_current_line()
  local line     = ffi.cast('uint8_t*', str)

  local pos      = vim.api.nvim_win_get_cursor(0)
  local col      = ffi.new('uint32_t', pos[2])

  local sel_from = ffi.new 'uint32_t[1]'
  local sel_to   = ffi.new 'uint32_t[1]'

  if lib.visual_block(line, col, sel_from, sel_to) then
    vim.api.nvim_win_set_cursor(0, { pos[1], sel_from[0] })
    vim.cmd [[execute "normal! \v"]]
    vim.api.nvim_win_set_cursor(0, { pos[1], sel_to[0] })
  end
end)
