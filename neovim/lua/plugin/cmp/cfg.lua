local plugin = require 'cmp'
local luasnip = require 'luasnip'

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
    ['<Cr>'] = plugin.mapping.confirm { select = true },
  },
  sources = {
    { name = 'path' },
    { name = 'buffer' },
    { name = 'nvim_lsp' },
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
    format = function(_, it)
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
    end,
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
