local k = require 'infra.key'
local ui = require 'infra.ui'

local map = k.map
local unmap = k.unmap
local map_cmd = k.map_cmd

-- disable
unmap({ 'v', 'i' }, '<C-k>') -- key chord
unmap({ 'n', 'v' }, '<C-m>') -- down
unmap({ 'n', 'v' }, '<C-p>') -- up
unmap({ 'n', 'v' }, 'H')     -- go page start
unmap({ 'n', 'v' }, 'L')     -- go page end
unmap('n', '?')              -- search backward
unmap('v', 'b')              -- select word backward
unmap({ 'n', 'v' }, 'q')     -- recording

-- disable history list
unmap('c', '<C-f>')
unmap({ 'n', 'v' }, 'q:')
unmap({ 'n', 'v' }, 'q/')
unmap({ 'n', 'v' }, 'q?')

-- case switching
map({ 'v' }, 'uj', 'u')
map({ 'v' }, 'uk', 'U')

-- buf
map_cmd({ 'n', 'v' }, 'ww', 'w')
map_cmd({ 'n', 'v' }, 'wa', 'wa')
map({ 'n', 'v' }, 'qq', function()
  if vim.bo.ft == 'neo-tree' then
    return
  end
  if vim.bo.bt == '' then
    vim.cmd 'BufDel'
  else
    vim.cmd 'q'
  end
end)
map_cmd({ 'n', 'v' }, 'qa', 'qa!')
map({ 'n', 'v' }, 'wq', function()
  vim.cmd 'w'
  vim.cmd 'BufDel'
end)

-- clsoe search hl
map_cmd('n', '<M-n>', 'noh')

-- toggle wrap line
map('n', 'wr', function()
  vim.wo.wrap = not vim.wo.wrap
end)

-- focus on quickfix list
map_cmd('n', 'cc', 'bo copen')

-- win nav
map('n', 'wh', '<C-w>h')
map('n', 'wj', '<C-w>j')
map('n', 'wk', '<C-w>k')
map('n', 'wl', '<C-w>l')

-- redo
map('n', 'U', '<C-R>')

-- go bottom
map({ 'n', 'v' }, 'ff', 'G')
-- go prev buf
map('n', 'bp', '<C-^>')
-- go prev/next position
map('n', 'cp', '<C-o>')
map('n', 'cn', '<C-i>')

-- select line/col/all
map('n', 'v<Space>', 'V')
map('n', 'vv', '<C-v>')
map('n', 'va', 'ggVG', true)

-- scroll line up/down
map('n', '<C-S-k>', '<C-e>')
map('n', '<C-S-j>', '<C-y>')

-- scroll L/R
map('n', 'H', '10zh', true)
map('n', 'L', '10zl', true)

-- go line head/end
map({ 'n', 'v' }, 'qh', '0')
map({ 'n', 'v' }, 'ql', '$')

-- quick word L/R
map({ 'n', 'v' }, '<M-h>', '<S-Left>')
map({ 'n', 'v' }, '<M-l>', '<S-Right>')

-- quick up/down
map({ 'n', 'v' }, '<C-k>', '6k', true)
map({ 'n', 'v' }, '<C-j>', '6j', true)
map({ 'n', 'v' }, 'qj', '18j', true)
map({ 'n', 'v' }, 'qk', '18k', true)

-- binary jump L/R
do
  local ns = vim.api.nvim_create_namespace 'binary-jump-target-hl'

  local prev_hl = nil
  local function clear_hl()
    if prev_hl ~= nil then
      vim.api.nvim_buf_del_extmark(prev_hl[1], ns, prev_hl[2])
      vim.api.nvim_buf_del_extmark(prev_hl[1], ns, prev_hl[3])
      vim.api.nvim_buf_del_extmark(prev_hl[1], ns, prev_hl[4])
      prev_hl = nil
    end
  end

  local range = nil

  local on_ev = nil
  local function hl(row, l, m, r)
    local buf = vim.api.nvim_get_current_buf()
    prev_hl = {
      buf,
      vim.api.nvim_buf_set_extmark(
        buf, ns,
        row - 1, l,
        { end_col = m, hl_group = 'BinaryJumpRange' }
      ),
      vim.api.nvim_buf_set_extmark(
        buf, ns,
        row - 1, m,
        { end_col = m + 1, hl_group = 'BinaryJumpMid' }
      ),
      vim.api.nvim_buf_set_extmark(
        buf, ns,
        row - 1, m + 1,
        { end_col = r + 1, hl_group = 'BinaryJumpRange' }
      ),
    }

    if on_ev == nil then
      on_ev = vim.api.nvim_create_autocmd({ 'CursorMoved', 'ModeChanged' }, {
        once = true,
        callback = function()
          clear_hl()
          range = nil
          on_ev = nil
          vim.on_key(nil, ns)
        end,
      })
      vim.on_key(function(key, _)
        -- if <Esc> was pressed
        if key == '\27' then
          clear_hl()
          range = nil
          if on_ev ~= nil then
            vim.api.nvim_del_autocmd(on_ev)
            on_ev = nil
          end
          vim.on_key(nil, ns)
        end
      end, ns)
    end
  end

  map({ 'n', 'v' }, '<C-h>', function()
    clear_hl()

    local pos = vim.api.nvim_win_get_cursor(0)
    local row = pos[1]
    local col = pos[2]

    local l
    if range == nil then
      l = 0
    else
      l = range[1]
    end
    range = { l, math.max(l, col - 1) }

    if range[1] == range[2] then
      vim.api.nvim_win_set_cursor(0, { row, range[1] })
      range = nil
      return
    end

    local m = math.floor((range[1] + range[2]) / 2)

    if on_ev ~= nil then
      vim.api.nvim_del_autocmd(on_ev)
      on_ev = nil
    end
    vim.api.nvim_win_set_cursor(0, { row, m })

    vim.schedule(function() hl(row, range[1], m, range[2]) end)
  end)
  map({ 'n', 'v' }, '<C-l>', function()
    clear_hl()

    local pos = vim.api.nvim_win_get_cursor(0)
    local row = pos[1]
    local col = pos[2]

    local max = #vim.api.nvim_get_current_line() - 1

    local r
    if range == nil then
      r = max
    else
      r = math.min(range[2], max)
    end
    range = { math.min(col + 1, r), r }

    if range[1] == range[2] then
      vim.api.nvim_win_set_cursor(0, { row, range[1] })
      range = nil
      clear_hl()
      return
    end

    local m = math.ceil((range[1] + range[2]) / 2)

    if on_ev ~= nil then
      vim.api.nvim_del_autocmd(on_ev)
      on_ev = nil
    end
    vim.api.nvim_win_set_cursor(0, { row, m })

    vim.schedule(function() hl(row, range[1], m, range[2]) end)
  end)
end

-- reduce/increase indent
map('v', 'h', function()
  if vim.api.nvim_get_mode().mode == 'V' then
    vim.api.nvim_feedkeys('<gv', 'n', false)
  else
    vim.api.nvim_feedkeys('h', 'n', false)
  end
end)
map('v', 'l', function()
  if vim.api.nvim_get_mode().mode == 'V' then
    vim.api.nvim_feedkeys('>gv', 'n', false)
  else
    vim.api.nvim_feedkeys('l', 'n', false)
  end
end)

-- yank abs path of current buf
map('n', 'bn', function()
  local buf = vim.api.nvim_get_current_buf()
  local pwd = vim.api.nvim_buf_get_name(buf)
  vim.fn.setreg('+', pwd)
end)

-- terminal to normal
map('t', '<M-n>', [[<C-\><C-n>]])
-- open terminal in wm
map('n', 'tw', function()
  io.popen 'alacritty'
end)

-- cycle wins
map('n', ';', function()
  local wins = vim.api.nvim_list_wins()
  local current_win = vim.api.nvim_get_current_win()
  table.sort(wins, function(l, r) return l < r end)
  for _, win in ipairs(wins) do
    if win <= current_win then
      goto continue
    end
    local ft = ui.buf_opt(ui.win_buf(win), 'filetype')
    local not_jump =
        ft == 'qf' or
        ft == 'fidget' or
        ft == ''
    if not not_jump then
      vim.schedule(function()
        vim.api.nvim_set_current_win(win)
      end)
      return
    end
    ::continue::
  end
  if wins[1] ~= nil then
    vim.schedule(function()
      vim.api.nvim_set_current_win(wins[1])
    end)
  end
end)

-- docs preview
map('n', '<C-p>', function()
  if vim.bo.ft == 'markdown' then
    vim.cmd 'MarkdownPreview'
    return
  end
end)

local Stack = require 'infra.stack'
local buf_stack = Stack:new()
local buf_stack_redo = Stack:new()
local navi_by_motion = false

vim.api.nvim_create_autocmd('BufLeave', {
  callback = function(args)
    vim.schedule(function()
      if navi_by_motion then
        navi_by_motion = false
        return
      end

      local info = vim.fn.getbufinfo(args.buf)[1]
      if info == nil or info.listed == 0 then
        return
      end

      local ft = vim.api.nvim_get_option_value('filetype', { buf = args.buf })
      if
          ft == 'neo-tree' or
          ft == 'toggleterm'
      then
        return
      end

      if buf_stack:top() ~= args.buf then
        vim.print(args.buf)
        buf_stack:push(args.buf)
      end
    end)
  end,
})

map('n', 'bb', function()
  local ft = vim.bo.ft
  if
      ft == 'neo-tree' or
      ft == 'fidget' or
      ft == 'qf'
  then
    return
  end

  -- buf is curr
  local buf = vim.api.nvim_get_current_buf()
  if buf_stack_redo:top() ~= buf then
    buf_stack_redo:push(buf)
  end

  local listed = false
  repeat
    -- buf is prev
    buf = buf_stack:pop()
    if buf ~= nil then
      local info = vim.fn.getbufinfo(buf)[1]
      if info ~= nil then
        listed = info.listed == 1
      end
    end
  until buf_stack.len == 0 or buf ~= vim.api.nvim_get_current_buf() and listed
  if
      buf == nil or
      (not listed) or
      (not vim.api.nvim_buf_is_valid(buf))
  then
    return
  end

  navi_by_motion = true
  vim.api.nvim_set_current_buf(buf)
end)

map('n', 'B', function()
  local ft = vim.bo.ft
  if
      ft == 'neo-tree' or
      ft == 'fidget' or
      ft == 'qf'
  then
    return
  end

  -- buf is curr
  local buf = vim.api.nvim_get_current_buf()
  if buf_stack:top() ~= buf then
    buf_stack:push(buf)
  end

  local listed = false
  repeat
    -- buf is next
    buf = buf_stack_redo:pop()
    if buf ~= nil then
      local info = vim.fn.getbufinfo(buf)[1]
      if info ~= nil then
        listed = info.listed == 1
      end
    end
  until buf_stack_redo.len == 0 or buf ~= vim.api.nvim_get_current_buf() and listed
  if
      buf == nil or
      (not listed) or
      (not vim.api.nvim_buf_is_valid(buf))
  then
    return
  end

  navi_by_motion = true
  vim.api.nvim_set_current_buf(buf)
end)
