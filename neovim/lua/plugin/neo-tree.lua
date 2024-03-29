local plugin = require 'neo-tree'

vim.o.fillchars = 'vert:▎,horiz:─'

plugin.setup {
  enable_diagnostics = false,

  default_component_configs = {
    indent = {
      indent_marker = '🭲',
      last_indent_marker = '🮡',
    },
  },
  event_handlers = {
    -- disable line number
    {
      event = 'before_render',
      handler = function()
        if vim.bo.filetype == 'neo-tree' then
          vim.cmd 'setlocal nonumber'
        end
      end,
    },
  }
}

vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    local term_width = vim.go.columns
    if term_width > 120 then
      vim.cmd 'Neotree show'
    end
  end
})

-- auto show/close neo-tree when window resized
local function is_neotree_visible()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local ft = vim.api.nvim_get_option_value('filetype', { buf = buf })
    if ft == 'neo-tree' then
      return true
    end
  end
  return false
end
local function neotree_show()
  if not is_neotree_visible() then
    vim.cmd 'Neotree show'
  end
end
local function neotree_close()
  if is_neotree_visible() then
    vim.cmd 'Neotree close'
  end
end
vim.api.nvim_create_autocmd('VimResized', {
  callback = function()
    local term_width = vim.go.columns
    if term_width > 120 then
      neotree_show()
    else
      neotree_close()
    end
  end
})
