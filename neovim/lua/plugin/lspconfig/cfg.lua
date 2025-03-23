local caps = require 'cmp_nvim_lsp'.default_capabilities()
caps.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
local plugin = require 'lspconfig'

-- for lsp names, see:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

plugin.biome.setup { -- Web
  capabilities = caps,
  root_dir = plugin.util.root_pattern '.git' or vim.fn.getcwd(),
}
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
plugin.omnisharp.setup { -- C#
  capabilities = caps,
  cmd = { 'OmniSharp' },
}
plugin.rust_analyzer.setup {
  capabilities = caps,
  settings = {
    ['rust-analyzer'] = {
      completion = {
        fullFunctionSignatures = { enable = true },
        snippets = {
          custom = {
            ['let statement'] = {
              prefix = 'lt',
              body = 'let $0 = ;',
            },
            ['thread spawn'] = {
              prefix = 'tsp',
              scope = 'expr',
              requires = 'std::thread',
              body = {
                'thread::spawn(move || {',
                '\t$0',
                '});',
              },
            },
            ['thread sleep'] = {
              prefix = 'tsl',
              scope = 'expr',
              requires = { 'std::thread', 'std::time::Duration' },
              body = 'thread::sleep(Duration::from_millis($0));',
            },
            ['heap box'] = {
              prefix = 'box',
              body = 'Box::new($0)',
            },
            ['reference cell'] = {
              prefix = 'rc',
              requires = 'std::rc::Rc',
              body = 'Rc::new($0)',
            },
            ['atomic reference cell'] = {
              prefix = 'arc',
              requires = 'std::sync::Arc',
              body = 'Arc::new($0)',
            },
            ['mutex'] = {
              prefix = 'mtx',
              requires = 'std::sync::Mutex',
              body = 'Mutex::new($0)',
            },
          },
        },
      },
    },
  },
}

plugin.hls.setup { capabilities = caps }                    -- Haskell
plugin.ruff.setup { capabilities = caps }                   -- Python fmt
plugin.html.setup { capabilities = caps }                   -- HTML
plugin.sqls.setup { capabilities = caps }                   -- SQL
plugin.taplo.setup { capabilities = caps }                  -- TOML
plugin.jdtls.setup { capabilities = caps }                  -- Java
plugin.gopls.setup { capabilities = caps }                  -- Go
plugin.cssls.setup { capabilities = caps }                  -- CSS
plugin.texlab.setup { capabilities = caps }                 -- LaTeX
plugin.bashls.setup { capabilities = caps }                 -- bash
plugin.clangd.setup { capabilities = caps }                 -- C/C++
plugin.denols.setup { capabilities = caps }                 -- Deno
plugin.yamlls.setup { capabilities = caps }                 -- YAML
plugin.pyright.setup { capabilities = caps }                -- Python
plugin.marksman.setup { capabilities = caps }               -- Markdown
plugin.tinymist.setup { capabilities = caps }               -- Typst
plugin.fsautocomplete.setup { capabilities = caps }         -- F#
plugin.kotlin_language_server.setup { capabilities = caps } -- Kotlin
