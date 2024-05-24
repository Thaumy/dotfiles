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

return {
  tdump = tdump,
  tprint = function(o)
    vim.print(tdump(o))
  end,
}
