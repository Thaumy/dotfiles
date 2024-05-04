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

-- disable
unmap({ 'v', 'i' }, '<C-k>') -- key chord
unmap({ 'n', 'v' }, '<C-m>') -- down
unmap({ 'n', 'v' }, '<C-p>') -- up
unmap({ 'n', 'v' }, 'H')     -- go page start
unmap({ 'n', 'v' }, 'L')     -- go page end
unmap({ 'n', 'v' }, 'q:')    -- command history display
unmap('c', '<C-f>')          -- command history display

-- redo
map('n', 'U', '<C-R>')
-- override but not write register
map('v', 'tp', '\'_dP')

-- go bottom
map({ 'n', 'v' }, 'ff', 'G')

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

local function win_ft(win)
  local win_current_buf = vim.api.nvim_win_get_buf(win)
  local ft = vim.api.nvim_buf_get_option(win_current_buf, 'filetype')
  return ft
end

-- cycle wins
map('n', ';', function()
  local wins = vim.api.nvim_list_wins()
  local current_win = vim.api.nvim_get_current_win()
  for _, win in ipairs(wins) do
    local can_switch =
        win ~= current_win and
        win_ft(win) ~= 'notify'

    if can_switch then
      vim.api.nvim_set_current_win(win)
      return
    end
  end
end)

-- bufferline:
-- cycle buffer R/L
map_cmd('n', '<M-;>', 'BufferLineCycleNext')
map_cmd('n', '<M-S-;>', 'BufferLineCyclePrev')
-- close buffer
map_cmd('n', '<M-x>', 'BufDel')

-- neo-tree:
-- toggle
map_cmd('n', 'e', 'Neotree action=show toggle=true')

-- nvim-ufo:
-- fold code block
map('n', '<M-k>', 'za')
-- expand code block
map('n', '<M-j>', 'zo')

-- toggleterm:
-- toggle
map_cmd('n', 't', 'ToggleTerm')
map('t', '<Esc>', '<cmd>ToggleTerm<CR>')

-- nvim-comment:
-- toggle comment
map_cmd('v', 'm', 'CommentToggle')
