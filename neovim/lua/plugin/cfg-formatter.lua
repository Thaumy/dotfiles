local vim = vim

local function setup()
  require("formatter").setup {
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
end

return setup()
