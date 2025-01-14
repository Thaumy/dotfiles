local caps = require 'cmp_nvim_lsp'.default_capabilities()
caps.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
local plugin = require 'lspconfig'

-- for lsp names, see:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

plugin.nil_ls.setup { -- Nix
  capabilities = caps,
  settings = {
    ['nil'] = {
      formatting = {
        command = { 'nixpkgs-fmt' },
      },
      nix = {
        flake = { autoArchive = true },
      },
    },
  },
}
plugin.lua_ls.setup {
  capabilities = caps,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
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
plugin.omnisharp.setup {
  capabilities = caps,
  cmd = { 'OmniSharp' },
}
plugin.rust_analyzer.setup {
  capabilities = caps,
  settings = {
    ['rust-analyzer'] = {
      completion = {
        fullFunctionSignatures = { enable = true },
      },
    },
  },
}

plugin.hls.setup { capabilities = caps }
plugin.ruff.setup { capabilities = caps }
plugin.html.setup { capabilities = caps }
plugin.sqls.setup { capabilities = caps }
plugin.taplo.setup { capabilities = caps } -- TOML
plugin.jdtls.setup { capabilities = caps }
plugin.gopls.setup { capabilities = caps }
plugin.cssls.setup { capabilities = caps }
plugin.texlab.setup { capabilities = caps }
plugin.bashls.setup { capabilities = caps }
plugin.jsonls.setup { capabilities = caps }
plugin.clangd.setup { capabilities = caps }
plugin.denols.setup { capabilities = caps }
plugin.yamlls.setup { capabilities = caps }
plugin.pyright.setup { capabilities = caps }
plugin.marksman.setup { capabilities = caps }
plugin.tinymist.setup { capabilities = caps }
plugin.fsautocomplete.setup { capabilities = caps } -- F#
plugin.kotlin_language_server.setup { capabilities = caps }
