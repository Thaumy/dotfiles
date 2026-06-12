local M = {}

function M:new()
  local t = { timer = vim.uv.new_timer() }
  return setmetatable(t, { __index = M })
end

function M:schedule(ms, f)
  -- If the timer is already active, it is simply updated.
  self.timer:start(ms, 0, function()
    -- No need to stop the timer, it's a one-shot timer.
    vim.schedule(f)
  end)
end

function M:drop()
  self.timer:close() -- Timer will be stopped internally.
end

return M
