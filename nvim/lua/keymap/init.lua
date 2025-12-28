require 'keymap.disabled'
require 'keymap.indent'
require 'keymap.buf_stack'
require 'keymap.cycle_wins'
require 'keymap.binary_jump'
require 'keymap.visual_block'
require 'keymap.blame_line'

local k = require 'infra.key'

local map = k.map
local map_cmd = k.map_cmd

-- zz with horizontal relocation and blank line control
map('n', 'zz', function()
  local total_lines = vim.api.nvim_buf_line_count(0)
  local top_line = vim.fn.line 'w0'
  local win_height = vim.api.nvim_win_get_height(0)
  local win_mid = math.floor(win_height / 2)

  local blank_lines = top_line + win_height - 1 - total_lines
  local scroll = vim.fn.winline() - win_mid - 1

  local view = vim.fn.winsaveview()

  -- allow up to 3 blank lines due to scrolling
  if blank_lines + scroll > 3 then
    view.topline = view.topline + 3 - blank_lines
    vim.notify 'EOF reached'
  else
    view.topline = view.topline + scroll
  end

  view.leftcol = 0
  vim.fn.winrestview(view)
end)

-- remap `textDocument/selectionRange`
vim.keymap.del('x', 'in')
map('x', '1', function()
  vim.lsp.buf.selection_range(1)
end)
vim.keymap.del('x', 'an')
map('x', '2', function()
  vim.lsp.buf.selection_range(-1)
end)

map('x', 'y', function()
  local from = vim.fn.getpos 'v'
  local to = vim.fn.getpos '.'
  local mode = vim.api.nvim_get_mode().mode

  local selected = vim.fn.getregion(from, to, { type = mode })
  local text = table.concat(selected, '\n')

  if mode == 'v' or mode == '\22' then
    -- visual or visual block
    local line = vim.api.nvim_get_current_line()
    -- if the last line break is selected
    if to[3] - 1 == #line then
      text = text .. '\n'
    end
  elseif mode == 'V' then
    -- visual line
    -- add line break to the head for the
    -- same behavior as normal yank (yy)
    text = '\n' .. text
  end

  vim.fn.setreg('+', text, mode)

  -- feed <Esc> to exit
  vim.api.nvim_input '\27'
end)

-- mouse yank/paste
map('n', '<RightMouse>', 'p', true)
map('x', '<RightMouse>', 'y', true)
map('x', '<M-RightMouse>', 'p', true)
map('x', '<MiddleMouse>', 'd', true)
map('i', '<RightMouse>', '<C-r>+', true)

-- case switching
map('x', 'uj', 'u')
map('x', 'uk', 'U')

-- buf
map({ 'n', 'x' }, 'ww', function()
  local ft = vim.bo.ft
  if
      ft == 'neo-tree' or
      ft == 'TelescopePrompt' or
      vim.bo.readonly or
      (not vim.bo.modifiable)
  then
    return
  end
  vim.cmd 'w'
end)
map_cmd({ 'n', 'x' }, 'wa', 'wa')
map({ 'n', 'x' }, 'ws', function()
  vim.cmd 'wa'
  vim.cmd 'qa'
end)
map({ 'n', 'x' }, 'qq', function()
  local ft = vim.bo.ft
  if ft == 'neo-tree' then return end
  if vim.bo.bt == '' or ft == 'buildlog' then
    vim.cmd 'BufDel'
  else
    vim.cmd 'q'
  end
end)
map_cmd({ 'n', 'x' }, 'qa', 'qa!')
map({ 'n', 'x' }, 'wq', function()
  if vim.bo.ft == 'neo-tree' then
    return
  end
  vim.cmd 'w'
  vim.cmd 'BufDel'
end)

-- clear search hl
map_cmd('n', '<C-n>', 'noh')

-- visual-block front/back insert
map('x', 'i', function()
  if vim.api.nvim_get_mode().mode == '\22' then
    vim.api.nvim_feedkeys('I', 'n', false)
  end
end)
map('x', 'a', function()
  if vim.api.nvim_get_mode().mode == '\22' then
    vim.api.nvim_feedkeys('A', 'n', false)
  end
end)

-- toggle wrap line
map('n', 'wr', function()
  vim.wo.wrap = not vim.wo.wrap
end)

-- focus on quickfix list
map('n', 'cc', function()
  if #vim.fn.getqflist() == 0 then
    vim.print 'qf list is empty'
  else
    vim.cmd 'bo copen'
  end
end)

-- delete quickfix row
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  callback = function()
    vim.keymap.set('n', 'dd', function()
        local lines = vim.fn.getqflist()
        local row = vim.api.nvim_win_get_cursor(0)[1]
        table.remove(lines, row)
        vim.fn.setqflist(lines, 'r')

        -- cursor relocation
        local max_row = #lines
        if row < max_row then
          vim.api.nvim_win_set_cursor(0, { row, 0 })
        elseif max_row ~= 0 then
          vim.api.nvim_win_set_cursor(0, { max_row, 0 })
        else
          vim.cmd 'q' -- quit if empty
        end
      end,
      { buffer = true }
    )
    vim.keymap.set('x', 'd', function()
        local from = (vim.fn.getpos 'v')[2]
        local to = (vim.fn.getpos '.')[2]

        local lines = vim.fn.getqflist()
        local len = #lines
        local new_len = len - (math.abs(to - from) + 1)

        local tail_start = math.max(from, to) + 1
        local tail_new_start = math.min(from, to)
        table.move(lines, tail_start, len, tail_new_start, lines)
        for i = new_len + 1, len do lines[i] = nil end
        vim.fn.setqflist(lines, 'r')

        -- feed <Esc> to exit visual mode
        vim.api.nvim_input '\27'

        -- cursor relocation
        local max_row = new_len
        if from < max_row then
          vim.print(from)
          vim.api.nvim_win_set_cursor(0, { from, 0 })
        elseif max_row ~= 0 then
          vim.print(max_row)
          vim.api.nvim_win_set_cursor(0, { max_row, 0 })
        else
          vim.cmd 'q' -- quit if empty
        end
      end,
      { buffer = true }
    )
  end,
})

-- win nav
map('n', 'wh', '<C-w>h')
map('n', 'wj', '<C-w>j')
map('n', 'wk', '<C-w>k')
map('n', 'wl', '<C-w>l')

-- redo
map('n', 'U', '<C-R>')

-- go bottom
map({ 'n', 'x' }, 'ff', 'G')
-- go prev/next position
map('n', 'cp', '<C-o>')
map('n', 'cn', '<C-i>')

-- select line/col/all
map('n', 'v<Space>', 'V')
map('n', 'vv', '<C-v>')
map('n', 'va', 'ggVG', true)

-- select/replace word
map('n', 'vw', 'viw')
map('n', 'cw', 'ciw')

-- scroll L/R
map('n', 'H', '10zh', true)
map('n', 'L', '10zl', true)

local function prefix_spaces_len(line)
  local spaces = 0
  for i = 1, #line do
    if line:byte(i) == 32 then
      spaces = spaces + 1
    else
      break
    end
  end
  return spaces
end

-- go line head/end
map({ 'n', 'x' }, 'qh', function()
  local line = vim.api.nvim_get_current_line()
  local spaces = prefix_spaces_len(line)

  local pos = vim.api.nvim_win_get_cursor(0)
  if spaces < pos[2] then
    pos[2] = spaces
  else
    pos[2] = 0
  end
  vim.api.nvim_win_set_cursor(0, pos)
end)
map({ 'n', 'x' }, 'ql', function()
  local line = vim.api.nvim_get_current_line()
  if #line == 0 then return end

  local spaces = prefix_spaces_len(line)

  local pos = vim.api.nvim_win_get_cursor(0)
  if spaces > pos[2] then
    pos[2] = spaces
  else
    pos[2] = #line - 1
  end
  vim.api.nvim_win_set_cursor(0, pos)
end)

-- quick word L/R
map({ 'n', 'x' }, '<M-h>', '<S-Left>')
map({ 'n', 'x' }, '<M-l>', '<S-Right>')

-- quick up/down
map({ 'n', 'x' }, '<C-k>', '6k', true)
map({ 'n', 'x' }, '<C-j>', '6j', true)
map({ 'n', 'x' }, 'qj', '18j', true)
map({ 'n', 'x' }, 'qk', '18k', true)

map({ 'n', 'x' }, 'rp', function()
  local curr_buf_ft = vim.api.nvim_get_option_value('ft', { buf = 0 })
  if curr_buf_ft == 'qf' then
    vim.api.nvim_feedkeys(':cdo s/', 'n', false)
    return
  end

  local mode = vim.api.nvim_get_mode().mode
  if mode == 'n' then
    vim.api.nvim_feedkeys(':%s/', 'n', false)
  elseif
      mode == 'v' or -- by char
      mode == 'V' or -- by line
      mode == '\22'  -- by block
  then
    vim.api.nvim_feedkeys([[:s/\%V]], 'n', false)
  end
end)

-- yank abs path of current buf
map('n', 'yp', function()
  vim.fn.setreg('+', vim.api.nvim_buf_get_name(0))
end)

-- yank abs path of current buf, with :line:col suffix
map('n', 'yl', function()
  local path = vim.api.nvim_buf_get_name(0)
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.fn.setreg('+', string.format('%s:%d:%d', path, pos[1], pos[2]))
end)

-- docs preview
map('n', '<C-p>', function()
  if vim.bo.ft == 'markdown' then
    vim.cmd 'MarkdownPreview'
    return
  end
end)

-- refresh buf
map_cmd({ 'n', 'x' }, 'rr', 'e')

-- yank whole buf
map_cmd('n', 'ya', '%y+')

-- go prev qf item
k.map('n', 'ck', function()
  local qf_list = vim.fn.getqflist()
  if #qf_list == 0 then
    vim.print 'qf list is empty'
  end

  local cursor_row = vim.api.nvim_win_get_cursor(0)[1]
  for i = cursor_row - 1, 1, -1 do
    if qf_list[i].valid == 1 then
      vim.fn.winrestview {
        col = vim.api.nvim_win_get_height(0),
        coladd = 0,
        curswant = 0,
        leftcol = 0,
        lnum = i,
        skipcol = 0,
        topfill = 0,
        topline = i,
      }

      local count = 0
      for j = i - 1, 1, -1 do
        if qf_list[j].valid == 1 then
          count = count + 1
        end
      end
      vim.print(count .. ' items above')

      return
    end
  end

  vim.print '󰘣 no more items'
end)

-- go next qf item
k.map('n', 'cj', function()
  local qf_list = vim.fn.getqflist()
  if #qf_list == 0 then
    vim.print 'qf list is empty'
  end

  local cursor_row = vim.api.nvim_win_get_cursor(0)[1]
  for i = cursor_row + 1, #qf_list do
    if qf_list[i].valid == 1 then
      vim.fn.winrestview {
        col = vim.api.nvim_win_get_height(0),
        coladd = 0,
        curswant = 0,
        leftcol = 0,
        lnum = i,
        skipcol = 0,
        topfill = 0,
        topline = i,
      }

      local count = 0
      for j = i + 1, #qf_list do
        if qf_list[j].valid == 1 then
          count = count + 1
        end
      end
      vim.print(count .. ' items below')

      return
    end
  end

  vim.print '󰘡 no more items'
end)
