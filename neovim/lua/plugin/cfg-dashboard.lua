local vim = vim

local function setup()
  require 'dashboard'.setup {
    config = {
      header   = {},
      center   = {},
      footer   = {},
      packages = { enable = false },
      shortcut = {
        {
          desc = "New",
          group = "_",
          key = 'n',
          action = function()
            vim.cmd "bd"
          end
        },
      },
    }
  }
end

return setup()
