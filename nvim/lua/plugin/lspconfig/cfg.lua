-- For more LSPs, see:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

vim.lsp.config('nil_ls', {
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
})

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        ignoreDir = { '.direnv' },
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
})

vim.lsp.config('omnisharp', {
  cmd = { 'OmniSharp' },
})

vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {
      cargo = {
        features = 'all',
      },
      check = {
        command = 'clippy',
      },
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
})

vim.lsp.enable {
  'hls',                    -- Haskell
  'ruff',                   -- Python fmt
  'html',                   -- HTML
  'sqls',                   -- SQL
  'taplo',                  -- TOML
  'jdtls',                  -- Java
  'gopls',                  -- Go
  'cssls',                  -- CSS
  'biome',                  -- Web FE langs
  'ts_ls',                  -- TypeScript
  'lua_ls',                 -- Lua
  'texlab',                 -- LaTeX
  'bashls',                 -- Bash
  'clangd',                 -- C/C++
  'denols',                 -- Deno
  'jsonls',                 -- JSON
  'nil_ls',                 -- Nix
  'yamlls',                 -- YAML
  'pyright',                -- Python
  'lemminx',                -- XML
  'protols',                -- Protocol Buffers
  'fish_lsp',               -- fish shell
  'marksman',               -- Markdown
  'tinymist',               -- Typst
  'omnisharp',              -- C#
  'rust_analyzer',          -- Rust
  'fsautocomplete',         -- F#
  'kotlin_language_server', -- Kotlin
}
