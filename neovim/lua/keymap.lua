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

-- LSP: fmt
map('n', 'qq', function() vim.lsp.buf.format { sync = true } end)
-- LSP: show LSP diagnostic in cursor line
map('n', '<M-a>', function() vim.diagnostic.open_float() end)
-- LSP: show def
map('n', '<M-a>', function() vim.lsp.buf.hover() end)
-- LSP: quick fix in cursor line
map('n', '<M-q>', function() vim.lsp.buf.code_action() end)

-- barbar: switch tab L/R
map_cmd('n', '<S-Right>', 'BufferNext')
map_cmd('n', '<S-Left>', 'BufferPrevious')

local nvim_tree_api = require 'nvim-tree.api'
-- nvim-tree: toggle
map('n', '<C-t>', function() nvim_tree_api.tree.toggle() end)
-- nvim-tree: next/prev file
map('n', '<Down>', function() nvim_tree_api.node.navigate.sibling.next() end)
map('n', '<Up>', function() nvim_tree_api.node.navigate.sibling.prev() end)
-- nvim-tree: open file
map('n', '<CR>', function() nvim_tree_api.node.open.edit() end)
