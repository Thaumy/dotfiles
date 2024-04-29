local plugin = require 'cmp'

plugin.setup {
  mapping = plugin.mapping.preset.insert {
    ['<C-k>'] = plugin.mapping.scroll_docs(-3),
    ['<C-j>'] = plugin.mapping.scroll_docs(3),
    ['<Tab>'] = plugin.mapping.confirm { select = true },
    ['<CR>'] = plugin.mapping.confirm { select = true },
  },
  sources = plugin.config.sources(
    { { name = 'nvim_lsp' } },
    { { name = 'buffer' } },
    { { name = 'path' } }
  ),
  completion = {
    completeopt = 'menu,menuone,noinsert'
  },
  snippet = {
    expand = function(args)
      (require 'luasnip').lsp_expand(args.body)
    end,
  },
}

plugin.setup.cmdline('/', {
  mapping = plugin.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

plugin.setup.cmdline(':', {
  mapping = plugin.mapping.preset.cmdline {
    -- Use arrow keys to select command
    ['<Up>'] = { c = plugin.mapping.select_prev_item {} },
    ['<Down>'] = { c = plugin.mapping.select_next_item {} },
    ['<Tab>'] = { c = plugin.mapping.confirm { select = false } },
  },
  sources = plugin.config.sources(
    { { name = 'path' } },
    { { name = 'cmdline' } }
  ),
  completion = {
    completeopt = 'menu,menuone,noinsert'
  }
})
