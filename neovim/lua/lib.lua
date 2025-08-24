local ffi = require 'ffi'

ffi.cdef [[
  bool visual_block(int8_t* line, size_t col, size_t* sel_from, size_t* sel_to);
]]

LIBNVIMCFG = ffi.load((os.getenv 'HOME') .. '/.config/libnvimcfg.so')
