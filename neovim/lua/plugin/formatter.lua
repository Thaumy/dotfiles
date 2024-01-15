local plugin = require 'formatter'

plugin.setup {
  logging = true,
  log_level = vim.log.levels.WARN,

  filetype = {
    markdown = {
      function()
        return {
          exe = "deno",
          args = {
            "fmt",
            '--ext',
            'md',
            "--prose-wrap=never",
            "-",
          },
          stdin = true
        }
      end
    }
  }
}
