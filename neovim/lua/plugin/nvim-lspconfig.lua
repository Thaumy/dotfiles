local plugin = require 'lspconfig'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

local util = require 'lspconfig/util'

-- See:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
plugin.hls.setup {
  capabilities = capabilities,
}
plugin.nil_ls.setup { -- Nix
  capabilities = capabilities,
  settings = {
    ['nil'] = {
      formatting = {
        command = { "nixpkgs-fmt" },
      },
    },
  },
}
plugin.html.setup {
  capabilities = capabilities,
}
--plugin.sqls.setup {
--  capabilities = capabilities,
--}
plugin.taplo.setup { -- TOML
  capabilities = capabilities,
}
plugin.jdtls.setup {
  capabilities = capabilities,
  cmd = { 'jdt-language-server' },
}
plugin.gopls.setup {
  capabilities = capabilities,
}
plugin.cssls.setup {
  capabilities = capabilities,
}
plugin.texlab.setup {
  capabilities = capabilities,
}
plugin.bashls.setup {
  capabilities = capabilities,
}
plugin.jsonls.setup {
  capabilities = capabilities,
}
plugin.clangd.setup {
  capabilities = capabilities,
}
--plugin.denols.setup {
--	capabilities = capabilities,
--}
plugin.yamlls.setup {
  capabilities = capabilities,
}
plugin.pyright.setup {
  capabilities = capabilities,
}
--plugin.marksman.setup {
--	capabilities = capabilities,
--}
plugin.omnisharp.setup {
  cmd = { 'OmniSharp' },
  capabilities = capabilities,
}
plugin.lua_ls.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
}
plugin.rust_analyzer.setup {
  capabilities = capabilities,
  filetypes = { 'rust' },
  root_dir = util.root_pattern('Cargo.toml'),
  settings = {
    ['rust_analyzer'] = {
      cargo = {
        allFeatures = true,
      }
    }
  }
}
plugin.fsautocomplete.setup { -- F#
  capabilities = capabilities,
}
plugin.kotlin_language_server.setup {
  capabilities = capabilities,
}
plugin.typst_lsp.setup {
  capabilities = capabilities,
}
