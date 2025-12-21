local ffi = require 'ffi'
local lib = LIBNVIMCFG

local M = {}

function M:new()
  local t = { ptr = ffi.gc(lib.u32_stack_new(), lib.u32_stack_drop) }
  return setmetatable(t, { __index = M })
end

function M:len()
  local len = lib.u32_stack_len(self.ptr)
  return tonumber(len)
end

function M:push(value)
  local u32 = ffi.new('uint32_t', value)
  lib.u32_stack_push(self.ptr, u32)
end

function M:top()
  local value = lib.u32_stack_top(self.ptr)
  if value ~= nil then
    return tonumber(value[0])
  end
end

function M:pop()
  local value = ffi.new 'uint32_t[1]'
  if lib.u32_stack_pop(self.ptr, value) then
    return tonumber(value[0])
  end
end

function M:clear()
  lib.u32_stack_clear(self.ptr)
end

return M
