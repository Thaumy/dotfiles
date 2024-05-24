local plugin = require 'lspconfig'

local caps = require('cmp_nvim_lsp').default_capabilities()
caps.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

local util = require 'lspconfig/util'

-- for lsp names, see:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

plugin.hls.setup {
  capabilities = caps,
}
plugin.nil_ls.setup { -- Nix
  capabilities = caps,
  settings = {
    ['nil'] = {
      formatting = {
        command = { 'nixpkgs-fmt' },
      },
    },
  },
}
plugin.html.setup {
  capabilities = caps,
}
--plugin.sqls.setup {
--  capabilities = caps,
--}
plugin.taplo.setup { -- TOML
  capabilities = caps,
}
plugin.jdtls.setup {
  capabilities = caps,
  cmd = { 'jdt-language-server' },
}
plugin.gopls.setup {
  capabilities = caps,
}
plugin.cssls.setup {
  capabilities = caps,
}
plugin.texlab.setup {
  capabilities = caps,
}
plugin.bashls.setup {
  capabilities = caps,
}
plugin.jsonls.setup {
  capabilities = caps,
}
plugin.clangd.setup {
  capabilities = caps,
}
plugin.denols.setup {
  capabilities = caps,
}
plugin.yamlls.setup {
  capabilities = caps,
}
plugin.pyright.setup {
  capabilities = caps,
}
plugin.marksman.setup {
  capabilities = caps,
}
plugin.omnisharp.setup {
  cmd = { 'OmniSharp' },
  capabilities = caps,
}
plugin.lua_ls.setup {
  capabilities = caps,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      },
      hint = {
        enable = true,
      },
      format = {
        enable = true,
        defaultConfig = {
          indent_style = 'space',
          indent_size = '2',
          quote_style = 'single',
          call_arg_parentheses = 'remove',
          trailing_table_separator = 'smart',
        },
      },
    },
  },
}
plugin.rust_analyzer.setup {
  capabilities = caps,
  filetypes = { 'rust' },
  root_dir = util.root_pattern('Cargo.toml'),
  settings = {
    ['rust-analyzer'] = {
      completion = {
        fullFunctionSignatures = {
          enable = true,
        }
      }
    }
  }
}
plugin.fsautocomplete.setup { -- F#
  capabilities = caps,
}
plugin.kotlin_language_server.setup {
  capabilities = caps,
}
plugin.typst_lsp.setup {
  capabilities = caps,
}
