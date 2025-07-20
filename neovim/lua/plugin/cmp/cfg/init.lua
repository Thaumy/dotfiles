local format = require 'plugin.cmp.cfg.format'
local plugin = require 'cmp'
local luasnip = require 'luasnip'
local compare = require 'cmp.config.compare'
local kind_compare = require 'plugin.cmp.cfg.kind_compare'
local crate_version_first = require 'plugin.cmp.cfg.crate_version_first'

plugin.setup {
  mapping = plugin.mapping.preset.insert {
    ['<M-k>'] = plugin.mapping.scroll_docs(-3),
    ['<M-j>'] = plugin.mapping.scroll_docs(3),
    ['<Cr>'] = plugin.mapping.confirm { select = true },
  },
  sources = {
    { name = 'path' },
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
  },
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  sorting = {
    comparators = {
      crate_version_first,
      compare.offset,
      compare.exact,
      compare.recently_used,
      compare.score,
      kind_compare,
      compare.sort_text,
    },
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
  window = {
    completion = {
      winhighlight = 'Normal:Normal,CursorLine:CmpMenuCursorLine',
    },
  },
  experimental = {
    ghost_text = true,
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
