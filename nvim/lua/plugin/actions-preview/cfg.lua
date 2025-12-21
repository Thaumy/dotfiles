local k = require 'infra.key'
local plugin = require 'actions-preview'

plugin.setup {
  telescope = {},
}

-- code actions in cursor line
k.map('n', '<M-q>', plugin.code_actions)
