local map = vim.api.nvim_set_keymap

map('n', '<C-m>', ':MarkdownPreview<CR>', { silent = true }) -- render
