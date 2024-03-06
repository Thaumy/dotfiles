local map = vim.api.nvim_set_keymap

-- redo
map('n', 'U', '<C-R>', {})
-- toggle nvim-tree
map('n', '<C-t>', ':NvimTreeToggle<CR>', { silent = true })
-- switch tab L/R
map('n', '<S-Right>', '<cmd>BufferNext<CR>', {})
map('n', '<S-Left>', '<cmd>BufferPrevious<CR>', {})
-- override but not write register
map('v', 'tp', '\'_dP', {})
-- fmt
map('n', '<S-q>', '<cmd>lua vim.lsp.buf.format { sync = true }<CR>', { silent = true })
-- show LSP diagnostic in cursor line
map('n', '<M-a>', '<cmd>lua vim.diagnostic.open_float()<CR>', { silent = true })
-- show def
map('n', '<M-a>', '<cmd>lua vim.lsp.buf.hover()<CR>', { silent = true })
-- LSP quick fix in cursor line
map('n', '<M-q>', '<cmd>lua vim.lsp.buf.code_action()<CR>', { silent = true })

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
