{ lib, inputs, config, pkgs, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;

  nvim-web-devicons = pkgs.vimUtils.buildVimPlugin {
    pname = "nvim-web-devicons";
    version = "2025-09-27";
    src = pkgs.fetchFromGitHub {
      owner = "Thaumy";
      repo = "nvim-web-devicons";
      rev = "ccfee7fe727ffdfbc6c44506d0cb62f0ceab9b14";
      hash = "sha256-cLXUT+Iiy/07zePEwfys2zUi4h/6FxQJM8RsB+n5J0Q=";
    };
  };

  nvim-bqf = pkgs.vimUtils.buildVimPlugin {
    pname = "nvim-bqf";
    version = "2026-03-19";
    src = pkgs.fetchFromGitHub {
      owner = "Thaumy";
      repo = "nvim-bqf";
      rev = "b11bbd9741f2980eae8261780b9605fc109b6447";
      hash = "sha256-TPX12JVvfSb2SHxWNMRXfI5Ju79Z78VIyrq3LX6LQE8=";
    };
    doCheck = false;
  };

  # Will be symlinked to the final plugin dir, mainly for plugin dev.
  localPlugins = [
    #{ name = "foo.nvim"; path = "/abs/path"; }
    #rec {
    #  name = "coq-goals.nvim";
    #  path = "/home/thaumy/thaumy-repo/${name}";
    #}
  ];
in
{
  nixpkgs.overlays = [ inputs.nvim-nightly.overlays.default ];

  programs.neovim = {
    enable = true;

    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      # infrastructures
      nui-nvim # ui components
      lazy-nvim # lazy plugin loader
      plenary-nvim # common utils
      promise-async # promise & async

      # colorizers or signs
      nvim-ufo # code block folding, [deps: promise-async]
      gitsigns-nvim # gutter git signs
      vim-illuminate # similar word hl
      catppuccin-nvim # color scheme
      nvim-web-devicons # icons
      nvim-colorizer-lua # color text hl
      todo-comments-nvim # TODOs hl, [deps: plenary-nvim]
      indent-blankline-nvim # indent lines
      rainbow-delimiters-nvim # colorful delimiters

      # user interfaces
      nvim-bqf # better quickfix
      fidget-nvim # notifications
      lualine-nvim # status line
      neo-tree-nvim # file explorer, [deps: plenary-nvim, nvim-web-devicons, nui-nvim]
      telescope-nvim # fuzzy finder
      bufferline-nvim # buffer tabs
      colorful-menu-nvim # hl for code completion menu
      actions-preview-nvim # code actions preview
      markdown-preview-nvim # markdown renderer
      nvim-treesitter-context # show current context

      # analyzers
      nvim-cmp # code completion, [deps: cmp-path, cmp-buffer, cmp-cmdline, cmp-nvim-lsp, luasnip, nvim-lspconfig]
      cmp-path # path completion source
      cmp-buffer # buffer completion source
      Ionide-vim # F# LSP support
      cmp_luasnip # luasnip completion source
      cmp-cmdline # cmdline completion source
      cmp-nvim-lsp # LSP completion source
      cmp-nvim-lua # nvim lua APIs completion source
      nvim-lspconfig # LSP support
      nvim-treesitter.withAllGrammars # language parser

      # input helpers
      luasnip # snippet
      neoformat # formatter
      mini-pairs # auto close pairs
      crates-nvim # crate.io cmp
      comment-nvim # better comment support
    ];

    extraPackages = with pkgs; [
      nil # Nix
      ruff # Python fmt
      sqls # SQL
      deno # Deno
      shfmt # Shell fmt
      gopls # Go
      taplo # TOML
      biome # Web
      pyright # Python
      lemminx # XML
      protols # Protocol Buffers
      fish-lsp # fish shell
      fantomas # F# fmt
      marksman # Markdown
      tinymist # Typst
      nixpkgs-fmt # Nix fmt
      rust-analyzer # Rust
      #ts_query_ls # Tree-sitter query
      fsautocomplete # F#
      omnisharp-roslyn # C#
      #coqPackages.coq-lsp # Coq
      vue-language-server # Vue
      jdt-language-server # Java
      lua-language-server # Lua
      bash-language-server # Bash
      yaml-language-server # YAML
      kotlin-language-server # Kotlin
      haskell-language-server # Haskell
      typescript-language-server # TypeScript
      vscode-langservers-extracted # mainly for jsonls
    ];
  };

  xdg.configFile = {
    # HACK: disable HM-generated init.lua to avoid build failures
    # caused by trying to create symlink outside $HOME
    "nvim/init.lua".enable = false;

    "nvim".source = mkSymlink "${homeDir}/cfg/nvim";

    "libnvimcfg.so".source =
      "${inputs.libnvimcfg.packages.${pkgs.stdenv.hostPlatform.system}.default}/lib/libnvimcfg.so";

    "nvim-plugins".source = pkgs.symlinkJoin {
      name = "nvim-plugins";
      paths = [ "${config.xdg.dataFile."nvim/site/pack/hm".source}/start" ]
        # symlink local plugin to vim pack dir
        ++ map
        (it: (pkgs.stdenv.mkDerivation {
          name = it.name;
          src = ./.;
          buildPhase = ''
            mkdir -p $out
            ln -s ${it.path} $out/${it.name}
          '';
        }))
        localPlugins;
    };

    "nvim-treesitter-parsers".source =
      let
        nvim-treesitter-parsers = pkgs.symlinkJoin {
          name = "nvim-treesitter-parsers";
          paths = pkgs.vimPlugins.nvim-treesitter.withAllGrammars.dependencies;
        };
      in
      mkSymlink nvim-treesitter-parsers;
  };

  home.packages = [
    (pkgs.symlinkJoin {
      name = "nvim-alias";
      paths = [ config.programs.neovim.finalPackage ];
      postBuild = "ln -s $out/bin/nvim $out/bin/v";
    })

    # HACK: use `hiPrio` to override neovim wrapper
    (lib.hiPrio (pkgs.runCommand "better-nvim.desktop" { } ''
      mkdir -p "$out/share/applications"
      cd "$out/share/applications"
      cp '${config.programs.neovim.finalPackage}/share/applications/nvim.desktop' .

      # Rename `Neovim wrapper` to `Neovim`
      sed -i 's/Name=Neovim wrapper/Name=Neovim/g' nvim.desktop

      # Fix nvim cannot be opened by nautilus(or other apps with xdg-mime default)
      sed -i 's/Exec=nvim %F/Exec=alacritty -e nvim %F/g' nvim.desktop
      sed -i 's/Terminal=true/Terminal=false/g' nvim.desktop
    ''))
  ];
}
