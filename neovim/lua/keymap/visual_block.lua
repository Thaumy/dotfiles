local map = require 'infra.key'.map
local Stack = require 'infra.stack'

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
  local stack_r = Stack:new()
  local moved = false
  while from >= 0 do
    local c = at(line, from)

    for ty, v in ipairs(bounds) do
      if moved and c == v[1] then
        -- is left bound and no more pending right bound
        if stack_r.len == 0 then
          return from, ty -- return left bound type
        elseif stack_r:top() == v[2] then
          stack_r:pop()   -- pop matched right bound
        end
      elseif c == v[2] then
        stack_r:push(c)
      end
    end

    from = from - 1
    moved = true
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
  local stack_l = Stack:new()
  local moved = false
  local max = #line
  while from < max do
    local c = at(line, from)

    for ty, v in ipairs(bounds) do
      if moved and c == v[2] then
        -- is right bound and no more pending left bound
        if stack_l.len == 0 then
          return from, ty -- return right bound type
        elseif stack_l:top() == v[1] then
          stack_l:pop()   -- pop matched left bound
        end
      elseif c == v[1] then
        stack_l:push(c)
      end
    end

    from = from + 1
    moved = true
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

local function select(row, col, l, r)
  local from, to = nil, nil
  if col - l > r - col then
    from, to = l + 1, r - 1
  else
    from, to = r - 1, l + 1
  end
  vim.api.nvim_win_set_cursor(0, { row, from })
  vim.cmd [[execute "normal! \v"]]
  vim.api.nvim_win_set_cursor(0, { row, to })
end

map('n', 'vb', function()
  local pos     = vim.api.nvim_win_get_cursor(0)
  local row     = pos[1]
  local col     = pos[2]

  local line    = vim.api.nvim_get_current_line()
  local l, l_ty = col, nil
  local r, r_ty = col, nil

  ::next::

  -- serach from `col` and `moved` above handles the
  -- situation when bound is under the cursor
  --              |                    |
  -- examples: '(<(), foo>)', '<(Vec<()>, i32)>'
  l, l_ty = find_l(line, l)
  if l_ty == nil then return end -- no more left bound

  r, r_ty = find_r(line, r)
  if r_ty == nil then return end -- no more right bound

  if l_ty == r_ty then
    select(row, col, l, r)
    return
  end

  -- handle broken bounds, like '<(foo, bar>)'

  local l_pair = find_l_pair(line, r + 1, l_ty)
  local r_pair = find_r_pair(line, l - 1, r_ty)

  if l_pair ~= nil and r_pair ~= nil then
    local d_l = math.min(col - l, l_pair - col)
    local d_r = math.min(r - col, col - r_pair)
    -- select the pair close to the cursor
    if d_l > d_r then
      select(row, col, r_pair, r)
    else
      select(row, col, l, l_pair)
    end
  elseif l_pair == nil and r_pair ~= nil then
    select(row, col, r_pair, r)
  elseif l_pair ~= nil and r_pair == nil then
    select(row, col, l, l_pair)
  else
    -- no matched pair found, try to search next valid pair
    --                 l        r
    -- for example: '[ <foo, bar) ]'
    l = l - 1
    r = r + 1
    goto next
  end
end)
