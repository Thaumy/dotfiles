local map = vim.api.nvim_set_keymap

local function cmd_map(mode, lhs, cmd_rhs)
  local rhs = string.format('<cmd>%s<CR>', cmd_rhs)
  map(mode, lhs, rhs, { silent = true })
end

local function lua_map(mode, lhs, lua_rhs)
  local rhs = string.format('lua %s', lua_rhs)
  cmd_map(mode, lhs, rhs)
end

-- redo
map('n', 'U', '<C-R>', {})
-- override but not write register
map('v', 'tp', '\'_dP', {})

-- disable
map('i', '<C-k>', '<nop>', {}) -- key chord
map('n', '<C-m>', '<nop>', {}) -- down
map('n', '<C-p>', '<nop>', {}) -- up
map('n', 'q:', '<nop>', {})    -- command history display
map('c', '<C-f>', '<nop>', {}) -- command history display

-- scroll line up/down
map('n', '<C-A-k>', '<C-e>', {})
map('n', '<C-A-j>', '<C-y>', {})

-- scroll page up/down
map('n', 'K', '<C-B>', {})
map('v', 'K', '<C-B>', {})
map('n', 'J', '<C-F>', {})
map('v', 'J', '<C-F>', {})

-- goto line head/end
map('n', 'H', '^', {})
map('v', 'H', '^', {})
map('n', 'L', '$', {})
map('v', 'L', '$', {})

-- quick L/R
map('n', '<C-H>', '8h', {})
map('v', '<C-H>', '8h', {})
map('n', '<C-L>', '8l', {})
map('v', '<C-L>', '8l', {})

-- quick up/down
map('n', '<C-K>', '5k', {})
map('v', '<C-K>', '5k', {})
map('n', '<C-J>', '5j', {})
map('v', '<C-J>', '5j', {})

-- LSP: fmt
lua_map('n', '<S-q>', 'vim.lsp.buf.format { sync = true }')
-- LSP: show LSP diagnostic in cursor line
lua_map('n', '<M-a>', 'vim.diagnostic.open_float()')
-- LSP: show def
lua_map('n', '<M-a>', 'vim.lsp.buf.hover()')
-- LSP: quick fix in cursor line
lua_map('n', '<M-q>', 'vim.lsp.buf.code_action()')

-- barbar: switch tab L/R
cmd_map('n', '<S-Right>', 'BufferNext')
cmd_map('n', '<S-Left>', 'BufferPrevious')

-- nvim-tree: toggle
cmd_map('n', '<C-t>', 'NvimTreeToggle')
-- nvim-tree: next/prev file
lua_map('n', '<Down>', 'require("nvim-tree.api").node.navigate.sibling.next()')
lua_map('n', '<Up>', 'require("nvim-tree.api").node.navigate.sibling.prev()')
-- nvim-tree: open file
lua_map('n', '<CR>', 'require("nvim-tree.api").node.open.edit()')

