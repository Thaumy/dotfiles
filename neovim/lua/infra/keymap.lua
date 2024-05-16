local map_opts = { noremap = true, silent = true }

local function unmap(modes, lhs)
  vim.keymap.set(modes, lhs, '<nop>', map_opts)
end

local function map(modes, lhs, rhs)
  vim.keymap.set(modes, lhs, rhs, map_opts)
  if type(rhs) == 'string' then
    unmap(modes, rhs) -- unmap original
  end
end

local function map_cmd(mode, lhs, cmd_rhs)
  local rhs = string.format(':%s<CR>', cmd_rhs)
  vim.keymap.set(mode, lhs, rhs, map_opts)
end

return {
  unmap = unmap,
  map = map,
  map_cmd = map_cmd
}
