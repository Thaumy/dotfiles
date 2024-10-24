local function trev(t)
  local rev = {}
  local len = #t
  for i = 1, len do
    rev[i] = t[len - i + 1]
  end
  return rev
end

local function tdump(o)
  if type(o) == 'table' then
    local s = '{ '
    for k, v in pairs(o) do
      if type(k) ~= 'number' then k = '"' .. k .. '"' end
      s = s .. '[' .. k .. '] = ' .. tdump(v) .. ','
    end
    return s .. '} '
  else
    return tostring(o)
  end
end

local function print(any)
  vim.api.nvim_echo({ { vim.inspect(any) } }, true, {})
end

return {
  trev = trev,
  print = print,
  tdump = tdump,
  tprint = function(o)
    vim.print(tdump(o))
  end,
}
