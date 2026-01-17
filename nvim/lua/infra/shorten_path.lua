local ffi = require 'ffi'
local lib = LIBNVIMCFG

return function(original)
  local original_ptr = ffi.cast('uint8_t*', original)
  local original_len = ffi.new('size_t', #original)
  local shorten_ptr  = ffi.new 'uint8_t*[1]'
  local shorten_len  = ffi.new 'size_t[1]'
  local ptr_to_drop  = ffi.new 'void*[1]'

  lib.shorten_path(
    original_ptr,
    original_len,
    shorten_ptr,
    shorten_len,
    ptr_to_drop
  )

  if shorten_ptr[0] ~= ffi.NULL then
    local shorten = ffi.string(shorten_ptr[0], shorten_len[0])
    if ptr_to_drop[0] ~= ffi.NULL then
      lib.shorten_path_drop(ptr_to_drop[0])
    end
    return shorten
  end

  return original
end
