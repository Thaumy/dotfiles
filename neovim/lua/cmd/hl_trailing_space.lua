-- highlight trailing space

local function trailing_spaces_len(line)
  local len = 0
  local i = -1
  while line:byte(i) == 32 do -- space char
    i = i - 1
    len = len + 1
  end
  return len
end

local ns = vim.api.nvim_create_namespace 'trailing-space-hl'
local ext_marks = {}
local debounce = require 'infra.debounce':new()

local cb = function(args)
  local buf = args.buf
  debounce:schedule(200, function()
    if
        (not vim.api.nvim_buf_is_valid(buf)) or
        vim.api.nvim_get_option_value('readonly', { buf = buf }) or
        (not vim.api.nvim_get_option_value('modifiable', { buf = buf })) or
        vim.api.nvim_get_option_value('buftype', { buf = buf }) ~= '' -- abnormal buffer
    then
      return
    end

    if ext_marks[buf] == nil then
      ext_marks[buf] = {}
    end

    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local insert_mode = vim.api.nvim_get_mode().mode == 'i'
    local curr_row = vim.api.nvim_win_get_cursor(0)[1]

    for row, line in ipairs(lines) do
      if ext_marks[buf][row] ~= nil then
        vim.api.nvim_buf_del_extmark(buf, ns, ext_marks[buf][row])
        ext_marks[buf][row] = nil
      end
      if row == curr_row and insert_mode then
        goto continue
      end
      if line:byte(-1) == 32 then -- space char
        local len = #line
        ext_marks[buf][row] = vim.api.nvim_buf_set_extmark(
          buf, ns,
          row - 1, len - trailing_spaces_len(line),
          { end_col = len, hl_group = 'TrailingSpace' }
        )
      end
      ::continue::
    end
  end)
end

vim.api.nvim_create_autocmd(
  { 'BufEnter', 'TextChanged', 'TextChangedI', 'InsertLeave' },
  { callback = cb }
)

vim.api.nvim_create_autocmd('BufDelete', {
  callback = function(args)
    ext_marks[args.buf] = nil
  end,
})
