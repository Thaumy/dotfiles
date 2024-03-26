local plugin = require 'noice'

plugin.setup {
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  cmdline = {
    enabled = true,
    view = "cmdline",
    format = {
      cmdline = false,
      search_down = false,
      search_up = false,
      filter = false,
      lua = false,
      help = false,
      input = false,
    }
  },
}
