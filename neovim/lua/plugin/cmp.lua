local plugin = require 'cmp'

plugin.setup {
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    completion = {
    },
    documentation = {
    },
  },
  mapping = plugin.mapping.preset.insert {
    ['<C-k>'] = plugin.mapping.scroll_docs(-3),
    ['<C-j>'] = plugin.mapping.scroll_docs(3),
    ['<Right>'] = plugin.mapping.confirm { select = false },
  },
  sources = plugin.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  }, {
    { name = 'buffer' },
  }),
  completion = {
    completeopt = 'menu,menuone,noinsert'
  }
}

-- Set configuration for specific filetype.
plugin.setup.filetype('gitcommit', {
  sources = plugin.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
plugin.setup.cmdline({ '/', '?' }, {
  mapping = plugin.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
plugin.setup.cmdline(':', {
  mapping = plugin.mapping.preset.cmdline(),
  sources = plugin.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
