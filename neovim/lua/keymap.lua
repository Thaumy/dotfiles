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

-- scroll page up/down
map({ 'n', 'v' }, 'K', '<C-b>')
map({ 'n', 'v' }, 'J', '<C-f>')

-- go line head/end
map({ 'n', 'v' }, 'qh', '0')
map({ 'n', 'v' }, 'ql', '$')

-- quick L/R
map({ 'n', 'v' }, '<C-h>', '8h', true)
map({ 'n', 'v' }, '<C-l>', '8l', true)

-- quick up/down
map({ 'n', 'v' }, '<C-k>', '6k', true)
map({ 'n', 'v' }, '<C-j>', '6j', true)

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

-- terminal to normal
map('t', '<M-n>', [[<C-\><C-n>]])

-- cycle wins
map('n', ';', function()
  local wins = vim.api.nvim_list_wins()
  table.sort(wins, function(l, r) return l < r end)
  local current_win = vim.api.nvim_get_current_win()
  for _, win in ipairs(wins) do
    if win <= current_win then
      goto continue
    end
    local ft = ui.win_ft(win)
    if
        ft == 'qf' or
        ft == 'fidget' or
        ft == ''
    then
    else
      vim.api.nvim_set_current_win(win)
      return
    end
    ::continue::
  end
  if wins[1] ~= nil then
    vim.api.nvim_set_current_win(wins[1])
  end
end)

-- docs preview
map('n', '<C-p>', function()
  local ft = ui.curr_buf_ft()
  if ft == 'markdown' then
    vim.cmd 'MarkdownPreview'
    return
  end
end)
