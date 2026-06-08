local plugin = require 'luasnip'
local s = plugin.snippet
local t = plugin.text_node
local i = plugin.insert_node
local events = require 'luasnip.util.events'

plugin.add_snippets('rust', {
  s('att', { t '#[', i(0), t ']' }),
  s('tst', { t '#[test]' }),
  s('cct', { t '#[cfg(test)]' }),
  s('ccf', { t '#[cfg(feature = "', i(0), t '")]' }),
  s('ccnf', { t '#[cfg(not(feature = "', i(0), t '"))]' }),
  s('debug_print', { t 'println!("{:?}", ', i(0), t ');' }),
})

plugin.add_snippets('lua', {
  s('debug_print', { t 'vim.print(vim.inspect(', i(0), t '))' }),
  s('debug_notify', { t 'vim.notify(vim.inspect(', i(0), t '))' }),
  s('debug_time',
    {
      t { 'local __s = os.clock()', '' },
      i(0),
      t { "vim.print(string.format('%.3f ms', (os.clock() - __s) * 1000))" },
    },
    {
      callbacks = {
        [-1] = {
          [events.leave] = function()
            -- feed <Esc> to exit
            vim.api.nvim_input '\27'
          end,
        },
      },
    }
  ),
})
