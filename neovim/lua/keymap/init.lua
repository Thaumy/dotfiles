local ui = require 'infra.ui'

require 'keymap.disabled'
require 'keymap.indent'
require 'keymap.buf_stack'
require 'keymap.cycle_wins'
require 'keymap.binary_jump'
require 'keymap.visual_block'

local k = require 'infra.key'

local map = k.map
local map_cmd = k.map_cmd

-- case switching
map({ 'v' }, 'uj', 'u')
map({ 'v' }, 'uk', 'U')

-- buf
map({ 'n', 'v' }, 'ww', function()
  local ft = vim.bo.ft
  if
      ft == 'neo-tree' or
      ft == 'toggleterm' or
      ft == 'TelescopePrompt' or
      vim.bo.readonly or
      (not vim.bo.modifiable)
  then
    return
  end
  vim.cmd 'w'
end)
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

-- clear search hl
map_cmd('n', '<C-n>', 'noh')

-- find git conflict mark
map('n', 'cf', function()
  vim.api.nvim_feedkeys('/<<<<<<< \r', 'n', false)
end)

-- visual-block front/back insert
map('v', 'i', function()
  if vim.api.nvim_get_mode().mode == '\22' then
    vim.api.nvim_feedkeys('I', 'n', false)
  end
end)
map('v', 'a', function()
  if vim.api.nvim_get_mode().mode == '\22' then
    vim.api.nvim_feedkeys('A', 'n', false)
  end
end)

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

-- select/replace word
map('n', 'vw', 'viw')
map('n', 'cw', 'ciw')

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

map({ 'n', 'v' }, 'rp', function()
  if ui.any_ft_buf 'qf' then
    vim.api.nvim_feedkeys(':cdo s/', 'n', false)
  else
    local mode = vim.api.nvim_get_mode().mode
    if mode == 'n' then
      vim.api.nvim_feedkeys(':%s/', 'n', false)
    elseif mode == 'v' or mode == 'V' then
      vim.api.nvim_feedkeys(':s/', 'n', false)
    end
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

-- docs preview
map('n', '<C-p>', function()
  if vim.bo.ft == 'markdown' then
    vim.cmd 'MarkdownPreview'
    return
  end
end)

-- refresh buf
map_cmd({ 'n', 'v' }, 'r', 'e')
