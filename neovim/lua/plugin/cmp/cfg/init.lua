local plugin = require 'cmp'
local format = require 'plugin.cmp.cfg.format'
local luasnip = require 'luasnip'

plugin.setup {
  mapping = plugin.mapping.preset.insert {
    ['<M-k>'] = plugin.mapping.scroll_docs(-3),
    ['<M-j>'] = plugin.mapping.scroll_docs(3),
    ['<Tab>'] = plugin.mapping.confirm { select = true },
    ['<Cr>'] = plugin.mapping.confirm { select = true },
  },
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
  },
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  formatting = {
    expandable_indicator = false,
    fields = { 'kind', 'abbr', 'menu' },
    format = format,
  },
}

local cmdline_mapping = plugin.mapping.preset.cmdline {
  -- Use arrow keys to select command
  ['<Up>'] = { c = plugin.mapping.select_prev_item {} },
  ['<Down>'] = { c = plugin.mapping.select_next_item {} },
  ['<Tab>'] = { c = plugin.mapping.confirm { select = false } },
}

plugin.setup.cmdline('/', {
  mapping = cmdline_mapping,
  sources = {
    { name = 'buffer' },
  },
})

plugin.setup.cmdline(':', {
  mapping = cmdline_mapping,
  sources = {
    { name = 'path' },
    { name = 'cmdline' },
  },
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
})
