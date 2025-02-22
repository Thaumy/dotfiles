local map = require 'infra.key'.map

local bounds = {
  { 034, 034 }, -- ""
  { 039, 039 }, -- ''
  { 040, 041 }, -- ()
  { 096, 096 }, -- ``
  { 091, 093 }, -- []
  { 060, 062 }, -- <>
  { 123, 125 }, -- {}
}

local function at(str, col)
  local i = col + 1
  return str:byte(i)
end

local function find_l(line, from)
  while from >= 0 do
    local c = at(line, from)

    local ty = nil
    for i, v in ipairs(bounds) do
      if c == v[1] then ty = i end
    end
    if ty ~= nil then return from, ty end

    from = from - 1
  end
  return nil, nil
end

local function find_l_pair(line, from, ty)
  local max = #line
  while from < max do
    if at(line, from) == bounds[ty][2] then
      return from
    end
    from = from + 1
  end
  return nil
end

local function find_r(line, from)
  local max = #line
  while from < max do
    local c = at(line, from)

    local ty = nil
    for i, v in ipairs(bounds) do
      if c == v[2] then ty = i end
    end

    if ty ~= nil then return from, ty end
    from = from + 1
  end
  return nil, nil
end

local function find_r_pair(line, from, ty)
  while from >= 0 do
    if at(line, from) == bounds[ty][1] then
      return from
    end
    from = from - 1
  end
  return nil
end

local function select(row, l, r)
  vim.api.nvim_win_set_cursor(0, { row, l + 1 })
  vim.cmd [[execute "normal! \v"]]
  vim.api.nvim_win_set_cursor(0, { row, r - 1 })
end

map('n', 'vb', function()
  local pos     = vim.api.nvim_win_get_cursor(0)
  local row     = pos[1]
  local col     = pos[2]

  local line    = vim.api.nvim_get_current_line()
  local l, l_ty = col - 1, nil
  local r, r_ty = col + 1, nil

  ::next::

  l, l_ty = find_l(line, l)
  if l == nil then return end

  r, r_ty = find_r(line, r)
  if r == nil then return end

  if l_ty == r_ty then
    select(row, l, r)
    return
  end

  local l_pair = find_l_pair(line, r + 1, l_ty)
  local r_pair = find_r_pair(line, l - 1, r_ty)

  if l_pair ~= nil and r_pair ~= nil then
    local d_l = math.abs((l + l_pair) / 2 - col)
    local d_r = math.abs((r + r_pair) / 2 - col)
    if d_l > d_r then
      select(row, r_pair, r)
    else
      select(row, l, l_pair)
    end
  elseif l_pair == nil and r_pair ~= nil then
    select(row, r_pair, r)
  elseif l_pair ~= nil and r_pair == nil then
    select(row, l, l_pair)
  else
    l = l - 1
    r = r + 1
    goto next
  end
end)
