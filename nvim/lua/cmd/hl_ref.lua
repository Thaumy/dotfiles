local lib = LIBNVIMCFG
local ffi = require 'ffi'
local vim_fn = vim.fn
local vim_api = vim.api
local vim_lsp = vim.lsp
local get_node_text = vim.treesitter.get_node_text
local nvim_buf_set_extmark = vim_api.nvim_buf_set_extmark

local ns = vim_api.nvim_create_namespace 'hl-ref'

local function by_ls(pos_params, buf, changedtick)
  local clients = vim_lsp.get_clients {
    bufnr = buf,
    method = 'textDocument/documentHighlight',
  }
  if #clients == 0 then return false end

  local function handler(err, hls)
    if err ~= nil or hls == nil then return end

    if
        (not vim_api.nvim_buf_is_valid(buf)) or
        changedtick ~= vim_api.nvim_buf_get_changedtick(buf)
    then
      return
    end

    for _, hl in ipairs(hls) do
      local range = hl.range

      local from = range.start
      local from_row = from.line
      local to = range['end']
      local to_row = to.line

      nvim_buf_set_extmark(buf, ns,
        from_row, from.character,
        { end_line = to_row, end_col = to.character, hl_group = 'HlRef' }
      )
    end
  end

  for _, client in ipairs(clients) do
    client:request('textDocument/documentHighlight', pos_params, handler, buf)
  end

  return true
end

local function by_ts(cursor_row, cursor_col, top_row, bot_row, buf, changedtick)
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

    local cursor_node_text = get_node_text(cursor_node, buf)
    local cursor_node_type = cursor_node:type()

    local queue = {}
    local queue_len = 0
    for node in view_node:iter_children() do
      queue_len = queue_len + 1
      queue[queue_len] = node
    end

    while #queue > 0 do
      local last_node = queue[queue_len]
      queue[queue_len] = nil
      queue_len = queue_len - 1

      if
          last_node:type() == cursor_node_type and
          get_node_text(last_node, buf) == cursor_node_text
      then
        local from_row, from_col, to_row, to_col = last_node:range()
        nvim_buf_set_extmark(buf, ns,
          from_row, from_col,
          { end_line = to_row, end_col = to_col, hl_group = 'HlRef' }
        )
      end

      for node in last_node:iter_children() do
        queue_len = queue_len + 1
        queue[queue_len] = node
      end
    end
  end)

  return true
end

local pre_alloc = lib.match_words_pre_alloc()

local function by_re(cursor_row, cursor_col, top_row, bot_row, win, buf)
  local cursor_line = vim_api.nvim_buf_get_lines(buf, cursor_row, cursor_row + 1, true)[1]
  local cursor_line_len = #cursor_line
  if cursor_line_len == 0 then return end

  local sel_from_ptr = ffi.new 'size_t[1]'
  local sel_to_ptr = ffi.new 'size_t[1]'

  local found = lib.select_word(
    ffi.cast('uint8_t*', cursor_line),
    ffi.new('size_t', cursor_line_len),
    ffi.new('size_t', cursor_col),
    sel_from_ptr,
    sel_to_ptr
  )
  if not found then return end

  local sel_from = tonumber(sel_from_ptr[0])
  local sel_to = tonumber(sel_to_ptr[0])
  local word = string.sub(cursor_line, sel_from + 1, sel_to)
  local word_len = #word

  local view_lines = vim_api.nvim_buf_get_lines(buf, top_row, bot_row + 1, true)
  local view_lines_len = #view_lines
  local have_fold = view_lines_len > vim_api.nvim_win_get_height(win)

  local l_i = 0
  while l_i < view_lines_len do
    local row = top_row + l_i
    l_i = l_i + 1

    if have_fold then
      local fold_end = vim_fn.foldclosedend(row)
      if fold_end ~= -1 then
        l_i = fold_end - top_row + 1
        goto continue
      end
    end

    local line = view_lines[l_i]
    local line_len = #line

    -- skip large line for performance
    if line_len < word_len or line_len > 200 then goto continue end

    local matches_ptr = ffi.new 'size_t[1]'
    local matches_len = tonumber(lib.match_words(
      pre_alloc,
      ffi.cast('uint8_t*', line),
      ffi.new('size_t', line_len),
      ffi.cast('uint8_t*', word),
      ffi.new('size_t', word_len),
      matches_ptr
    ))
    if matches_len == 0 then goto continue end
    local matches = ffi.cast('size_t*', matches_ptr[0])

    for m_i = 0, matches_len - 1, 2 do
      local match_l = tonumber(matches[m_i])
      local match_r = tonumber(matches[m_i + 1])
      nvim_buf_set_extmark(buf, ns,
        row, match_l,
        { end_col = match_r, hl_group = 'HlRef' }
      )
    end

    ::continue::
  end
end

local debounce = require 'infra.debounce':new()

HL_REF = true

vim_api.nvim_create_autocmd(
  { 'CursorMoved', 'CursorMovedI', 'LspProgress' }, {
    callback = function(args)
      if not HL_REF then return end

      if args.event == 'LspProgress' then
        local params = args.data.params
        if params ~= nil then
          local value = params.value
          if value ~= nil and value.kind ~= 'end' then
            return
          end
        else
          return
        end
      end

      debounce:schedule(200, function()
        local buf = vim_api.nvim_get_current_buf()

        if vim_api.nvim_get_option_value('buftype', { buf = buf }) ~= '' then
          return
        end

        vim_api.nvim_buf_clear_namespace(buf, ns, 0, -1)

        if not HL_REF then return end

        local pos_params = vim_lsp.util.make_position_params(0, 'utf-8')
        local changedtick = vim_api.nvim_buf_get_changedtick(buf)

        if by_ls(pos_params, buf, changedtick) then return end

        local cursor_pos = pos_params.position
        local cursor_row = cursor_pos.line
        local cursor_col = cursor_pos.character

        local win = vim_api.nvim_get_current_win()
        local top_row = vim_fn.line('w0', win) - 1
        local bot_row = vim_fn.line('w$', win) - 1

        if
            by_ts(
              cursor_row, cursor_col,
              top_row, bot_row,
              buf, changedtick
            )
        then
          return
        end

        by_re(cursor_row, cursor_col, top_row, bot_row, win, buf)
      end)
    end,
  })
