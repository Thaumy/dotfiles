local map = vim.api.nvim_set_keymap

map('n', '<S-q>', ':Format<CR>', { silent = true })          -- fmt
map('n', '<C-m>', ':MarkdownPreview<CR>', { silent = true }) -- render
