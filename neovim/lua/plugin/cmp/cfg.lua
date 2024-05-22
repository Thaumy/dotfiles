local plugin = require 'cmp'

local kind_map = {
  ['Enum'] = '󰣥',
  ['Text'] = '󰊄',
  ['Field'] = '󱪲',
  ['Value'] = '󰢡',
  ['Module'] = '󰐱',
  ['Method'] = '󰊕',
  ['Struct'] = '󱊈',
  ['Keyword'] = ' ',
  ['Snippet'] = '󰉁',
  ['Constant'] = '󰨓',
  ['Variable'] = '󰫧',
  ['Function'] = '󰊕',
  ['Interface'] = '󱘖',
  ['Reference'] = ' ',
  ['EnumMember'] = '󱇠',
}

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
  formatting = {
    expandable_indicator = false,
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, it)
      if it.kind ~= nil and kind_map[it.kind] ~= nil then
        it.kind = kind_map[it.kind]
      end
      if it.abbr ~= nil then
        it.abbr = string.sub(it.abbr, 1, 24)
      end
      if it.menu ~= nil then
        it.menu = string.sub(it.menu, 1, 80)
      end
      return it
    end
  }
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
