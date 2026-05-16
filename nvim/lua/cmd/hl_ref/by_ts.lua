local vim_uv = vim.uv
local vim_api = vim.api
local get_node_text = vim.treesitter.get_node_text
local nvim_buf_set_extmark = vim_api.nvim_buf_set_extmark

local timer = vim_uv.new_timer()

return function(ns, buf, changedtick, cursor_row, cursor_col, top_row, bot_row)
  local parser = vim.treesitter.get_parser(buf)
  if parser == nil then return false end

  parser:parse(nil, function(err, trees)
    if
        err ~= nil or -- currently only possible for timeouts
        (not vim_api.nvim_buf_is_valid(buf)) or
        changedtick ~= vim_api.nvim_buf_get_changedtick(buf)
    then
      return
    end

    -- `trees` will be `nil` only if the parse timed out,
    -- but we have already checked by `err ~= nil`
    local root_node = trees[1]:root()

    local view_node = root_node:named_descendant_for_range(top_row, 0, bot_row + 1, 0)
    if view_node == nil then return end

    local cursor_node = view_node:named_descendant_for_range(cursor_row, cursor_col, cursor_row, cursor_col)
    if cursor_node == nil then return end
    do
      local from_row, _, to_row = cursor_node:range()
      if from_row ~= to_row then return end
    end

    local cursor_node_text = get_node_text(cursor_node, buf)
    local cursor_node_type = cursor_node:type()

    local node_iters = { view_node:iter_children() }
    local node_iters_len = 1

    local function render()
      local n = 0
      local deadline = vim_uv.hrtime() + 1000000 -- 1 ms

      while node_iters_len > 0 do
        n = n + 1

        local node_iter = node_iters[node_iters_len]
        local node = node_iter()

        if node == nil then
          node_iters[node_iters_len] = nil
          node_iters_len = node_iters_len - 1
          goto continue
        end

        local from_row, from_col, to_row, to_col = node:range()
        if to_row < top_row or bot_row < from_row then
          -- node range does not overlap with the view range
          goto continue
        end

        if
            from_row == to_row and
            node:type() == cursor_node_type and
            node:child_count() == 0 and
            get_node_text(node, buf) == cursor_node_text
        then
          nvim_buf_set_extmark(buf, ns,
            from_row, from_col,
            { end_col = to_col, hl_group = 'HlRef' }
          )
        else
          node_iters_len = node_iters_len + 1
          node_iters[node_iters_len] = node:iter_children()
        end

        ::continue::
      end

      if n % 100 == 0 and vim_uv.hrtime() > deadline then
        timer:start(0, 0, vim.schedule_wrap(render))
        return
      end
    end

    render()
  end)

  return true
end
