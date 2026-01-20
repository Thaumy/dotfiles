local k = require 'infra.key'
local ffi = require 'ffi'
local lib = LIBNVIMCFG

local function case_conv(from, code)
  if code < 0 or code > 7 then return end

  local from_ptr = ffi.cast('uint8_t*', from)
  local from_len = ffi.new('size_t', #from)
  local to_convention = ffi.new('uint8_t', code)
  local to_ptr = ffi.new 'uint8_t*[1]'
  local to_len = ffi.new 'size_t[1]'
  local ptr_to_drop = ffi.new 'void*[1]'

  lib.case_conv(
    from_ptr,
    from_len,
    to_convention,
    to_ptr,
    to_len,
    ptr_to_drop
  )

  local to = ffi.string(to_ptr[0], to_len[0])
  lib.case_conv_drop(ptr_to_drop[0])

  return to
end

local map = {
  ['s'] = 0,
  ['us'] = 1,
  ['k'] = 2,
  ['uk'] = 3,
  ['uc'] = 4,
  ['lc'] = 5,
  ['ti'] = 6,
  ['tr'] = 7,
}

k.map('x', 'co', function()
  local from = vim.fn.getpos 'v'
  local to = vim.fn.getpos '.'
  local mode = vim.api.nvim_get_mode().mode

  local selected = vim.fn.getregion(from, to, { type = mode })
  local text = table.concat(selected, '\n')

  vim.ui.input({ prompt = 'convention: ' }, function(short_name)
    local code = map[short_name]
    if code == nil then
      vim.cmd 'normal! \27'
      vim.print 'unknown convention short name'
      return
    end

    local converted = case_conv(text, code)
    vim.cmd(string.format('normal! s%s\27', converted))
  end)
end)
