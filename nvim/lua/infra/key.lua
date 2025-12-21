local map_opts = { noremap = true, silent = true }

local function unmap(modes, lhs)
  vim.keymap.set(modes, lhs, '<nop>', map_opts)
end

local function map(modes, lhs, rhs, keep_rhs)
  vim.keymap.set(modes, lhs, rhs, map_opts)
  if keep_rhs == true then
    return
  end
  if type(rhs) == 'string' then
    unmap(modes, rhs) -- unmap original
  end
end

local function map_cmd(mode, lhs, cmd_rhs)
  vim.keymap.set(mode, lhs, function()
    vim.cmd(cmd_rhs)
  end, map_opts)
end

return {
  unmap = unmap,
  map = map,
  map_cmd = map_cmd,
}
