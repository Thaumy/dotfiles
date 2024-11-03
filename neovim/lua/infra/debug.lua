local function trev(t)
  local rev = {}
  local len = #t
  for i = 1, len do
    rev[i] = t[len - i + 1]
  end
  return rev
end

local function print(any)
  vim.api.nvim_echo({ { vim.inspect(any) } }, true, {})
end

local function notify(any)
  vim.notify(vim.inspect(any))
end

return {
  trev = trev,
  print = print,
  notify = notify,
}
