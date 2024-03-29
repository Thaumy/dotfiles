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
