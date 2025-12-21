local M = {}

function M:new()
  local t = { timer = nil }
  return setmetatable(t, { __index = M })
end

function M:schedule(millisecs, f)
  if self.timer ~= nil then
    self.timer:close()
  end

  self.timer = vim.uv.new_timer()
  self.timer:start(millisecs, 0, function()
    self.timer:stop()
    self.timer:close()
    self.timer = nil
    vim.schedule(f)
  end)
end

return M
