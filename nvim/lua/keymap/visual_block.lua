local lib = LIBNVIMCFG
local ffi = require 'ffi'
local map = require 'infra.key'.map
local vim_api = vim.api

local pre_alloc = lib.visual_block_pre_alloc()

map('n', 'vb', function()
  local line = vim_api.nvim_get_current_line()
  local line_ptr = ffi.cast('uint8_t*', line)
  local line_len = ffi.new('size_t', #line)

  local pos = vim_api.nvim_win_get_cursor(0)
  local cursor_col = ffi.new('size_t', pos[2])

  local sel_from = ffi.new 'size_t[1]'
  local sel_to = ffi.new 'size_t[1]'

  if lib.visual_block_select(
        pre_alloc,
        line_ptr,
        line_len,
        cursor_col,
        sel_from,
        sel_to
      )
  then
    vim_api.nvim_win_set_cursor(0, { pos[1], tonumber(sel_from[0]) })
    vim.cmd [[execute "normal! \v"]]
    vim_api.nvim_win_set_cursor(0, { pos[1], tonumber(sel_to[0]) })
  end
end)
