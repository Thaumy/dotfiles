local function map(mode, lhs, rhs)
  local opts = { noremap = true, silent = true }
  vim.keymap.set(mode, lhs, rhs, opts)
end

local function unmap(mode, lhs)
  map(mode, lhs, '<nop>')
end

local function map_cmd(mode, lhs, cmd_rhs)
  local rhs = string.format('<cmd>%s<CR>', cmd_rhs)
  map(mode, lhs, rhs)
end

-- disable
unmap('i', '<C-k>') -- key chord
unmap('n', '<C-m>') -- down
unmap('n', '<C-p>') -- up
unmap('n', 'q:')    -- command history display
unmap('c', '<C-f>') -- command history display

-- redo
map('n', 'U', '<C-R>')
-- override but not write register
map('v', 'tp', '\'_dP')

-- scroll line up/down
map('n', '<C-A-k>', '<C-e>')
map('n', '<C-A-j>', '<C-y>')

-- scroll page up/down
map('n', 'K', '<C-B>')
map('v', 'K', '<C-B>')
map('n', 'J', '<C-F>')
map('v', 'J', '<C-F>')

-- goto line head/end
map('n', 'H', '^')
map('v', 'H', '^')
map('n', 'L', '$')
map('v', 'L', '$')

-- quick L/R
map('n', '<C-H>', '8h')
map('v', '<C-H>', '8h')
map('n', '<C-L>', '8l')
map('v', '<C-L>', '8l')

-- quick up/down
map('n', '<C-K>', '5k')
map('v', '<C-K>', '5k')
map('n', '<C-J>', '5j')
map('v', '<C-J>', '5j')

local function win_ft(win)
  local win_current_buf = vim.api.nvim_win_get_buf(win)
  local ft = vim.api.nvim_buf_get_option(win_current_buf, 'filetype')
  return ft
end

-- cycle wins
map('n', '<M-;>', function()
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

-- lsp:
-- fmt
map('n', 'qq', function() vim.lsp.buf.format { sync = true } end)
-- go def
map('n', '<M-d>', function() vim.lsp.buf.definition() end)
-- show def
map('n', '<M-a>', function() vim.lsp.buf.hover() end)
-- quick fix in cursor line
map('n', '<M-q>', function() vim.lsp.buf.code_action() end)

-- bufferline:
-- switch buffer L/R
map_cmd('n', '<S-Right>', 'BufferLineCycleNext')
map_cmd('n', '<S-Left>', 'BufferLineCyclePrev')
-- close buffer
map_cmd('n', '<S-Up>', 'BufDel')

-- neo-tree:
-- toggle
map_cmd('n', '<C-t>', 'Neotree action=show toggle=true')

-- nvim-ufo:
-- fold code block
map('n', '<M-k>', 'za')
-- expand code block
map('n', '<M-j>', 'zo')
