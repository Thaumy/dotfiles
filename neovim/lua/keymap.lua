local ui = require 'infra.ui'
local k = require 'infra.keymap'

local map = k.map
local unmap = k.unmap
local map_cmd = k.map_cmd

-- disable
unmap({ 'v', 'i' }, '<C-k>') -- key chord
unmap({ 'n', 'v' }, '<C-m>') -- down
unmap({ 'n', 'v' }, '<C-p>') -- up
unmap({ 'n', 'v' }, 'H')     -- go page start
unmap({ 'n', 'v' }, 'L')     -- go page end

-- disable history list
unmap('c', '<C-f>')
unmap({ 'n', 'v' }, 'q:')
unmap({ 'n', 'v' }, 'q/')
unmap({ 'n', 'v' }, 'q?')

-- buf
map_cmd('n', 'ww', 'w')
map_cmd('n', 'wa', 'wa')
map('n', 'qq', function()
  if vim.bo.bt == '' then
    vim.cmd 'BufDel'
  else
    vim.cmd 'q'
  end
end)
map_cmd('n', 'qa', 'qa!')
map('n', 'wq', function()
  vim.cmd 'w'
  vim.cmd 'BufDel'
end)

-- redo
map('n', 'U', '<C-R>')
-- override but not write register
map('v', 'tp', '\'_dP')

-- go bottom
map({ 'n', 'v' }, 'ff', 'G')

-- go prev buf
map('n', 'b', '<C-^>')

-- select line/col
map('n', 'v<Space>', 'V')
map('n', 'vv', '<C-v>')

-- scroll line up/down
map('n', '<C-S-k>', '<C-e>')
map('n', '<C-S-j>', '<C-y>')

-- scroll page up/down
map({ 'n', 'v' }, 'K', '<C-b>')
map({ 'n', 'v' }, 'J', '<C-f>')

-- goto line head/end
map({ 'n', 'v' }, 'qh', '^')
map({ 'n', 'v' }, 'ql', '$')

-- quick L/R
map({ 'n', 'v' }, '<C-h>', '8h')
map({ 'n', 'v' }, '<C-l>', '8l')

-- quick up/down
map({ 'n', 'v' }, '<C-k>', '6k')
map({ 'n', 'v' }, '<C-j>', '6j')

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
map('t', '<M-n>', '<C-\\><C-n>')

-- cycle wins
map('n', ';', function()
  local wins = vim.api.nvim_list_wins()
  local current_win = vim.api.nvim_get_current_win()
  for _, win in ipairs(wins) do
    local can_switch =
        win ~= current_win and
        ui.win_ft(win) ~= 'notify'

    if can_switch then
      vim.api.nvim_set_current_win(win)
      return
    end
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
