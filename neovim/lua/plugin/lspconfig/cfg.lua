local plugin = require 'lspconfig'

-- for lsp names, see:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

vim.lsp.enable('biome', {
  root_dir = plugin.util.root_pattern '.git' or vim.fn.getcwd(),
})

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
  'lua_ls',                 -- Lua
  'texlab',                 -- LaTeX
  'bashls',                 -- bash
  'clangd',                 -- C/C++
  'denols',                 -- Deno
  'nil_ls',                 -- Nix
  'yamlls',                 -- YAML
  'pyright',                -- Python
  'marksman',               -- Markdown
  'tinymist',               -- Typst
  'omnisharp',              -- C#
  'rust_analyzer',          -- Rust
  'fsautocomplete',         -- F#
  'kotlin_language_server', -- Kotlin
}
