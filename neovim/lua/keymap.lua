local vim = vim

local map = vim.api.nvim_set_keymap

function Fmt()
  if vim.bo.filetype == "markdown" then
    vim.cmd "Format"
  else
    vim.lsp.buf.format { sync = true }
  end
end

local function setup()
  map("n", "U", "<C-R>", {})                               -- redo
  map("n", "q:", "<nop>", {})                                  -- disable command history display
  map("n", "<C-M>", ":MarkdownPreview<CR>", { silent = true }) -- render markdown
  map("n", "<C-T>", ":NvimTreeToggle<CR>", { silent = true })  -- toggle nvim-tree

  -- hole page up/down
  map("n", "K", "<C-B>", {})
  map("v", "K", "<C-B>", {})
  map("n", "J", "<C-F>", {})
  map("v", "J", "<C-F>", {})

  -- goto line head/end
  map("n", "H", "^", {})
  map("v", "H", "^", {})
  map("n", "L", "$", {})
  map("v", "L", "$", {})

  -- quick left/right
  map("n", "<C-H>", "8h", {})
  map("v", "<C-H>", "8h", {})
  map("n", "<C-L>", "8l", {})
  map("v", "<C-L>", "8l", {})

  -- quick up/down
  map("n", "<C-K>", "5k", {})
  map("v", "<C-K>", "5k", {})
  map("n", "<C-J>", "5j", {})
  map("v", "<C-J>", "5j", {})

  -- override but not write register
  map("v", "tp", "\"_dP", {})

  -- formatting
  map("n", "<S-q>", "<cmd>lua Fmt()<CR>", { silent = true })
end

return setup()
