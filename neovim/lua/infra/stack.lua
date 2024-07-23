local M = {}

function M:new()
  local t = { len = 0, stack = {} }
  return setmetatable(t, { __index = M })
end

function M:len()
  return self.len
end

function M:push(value)
  local new_len = self.len + 1
  self.stack[new_len] = value
  self.len = new_len
end

function M:top()
  if self.len == 0 then
    return nil
  end

  return self.stack[self.len]
end

function M:pop()
  if self.len == 0 then
    return nil
  end

  local value = self.stack[self.len]
  self.len = self.len - 1

  return value
end

function M:clear()
  self.len = 0
end

return M
