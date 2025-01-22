local plugin = require 'luasnip'
local s = plugin.snippet
local t = plugin.text_node
local i = plugin.insert_node

plugin.add_snippets('rust', {
  s('att', { t '#[', i(0), t ']' }),
  s('tst', { t '#[test]' }),
  s('cct', { t '#[cfg(test)]' }),
  s('ccf', { t '#[cfg(feature = "', i(0), t '")]' }),
  s('ccnf', { t '#[cfg(not(feature = "', i(0), t '"))]' }),
})
