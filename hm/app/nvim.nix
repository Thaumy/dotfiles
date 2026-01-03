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

  git-messenger-vim = pkgs.vimUtils.buildVimPlugin {
    pname = "git-messenger.vim";
    version = "2025-01-23";
    src = pkgs.fetchFromGitHub {
      owner = "Thaumy";
      repo = "git-messenger.vim";
      rev = "566545a19c4a5b974c4dedce7fbbcf88292250a7";
      hash = "sha256-6WG1JOr16qL6StSSinpjvaRqb6OmktlGOGLZXej6AT0=";
    };
  };

  neo-tree-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "neo-tree.nvim";
    version = "2026-01-03";
    src = pkgs.fetchFromGitHub {
      owner = "Thaumy";
      repo = "neo-tree.nvim";
      rev = "07555ed6653f1f2bb03b663db4ef2faadd4c1a60";
      hash = "sha256-MaB+TqClstHQPTzUiHV0Sfm5qVLYa/m9frHadiUnGKQ=";
    };
    doCheck = false;
  };
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
      nvim-bufdel # better buffer delete
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
      git-messenger-vim # git blame popup
      colorful-menu-nvim # hl for code completion menu
      actions-preview-nvim # code actions preview
      markdown-preview-nvim # markdown renderer

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
      crates-nvim # crate.io cmp
      comment-nvim # better comment support
      autoclose-nvim # auto close pairs and brackets
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
      fish-lsp # fish shell
      fantomas # F# fmt
      marksman # Markdown
      tinymist # Typst
      nixpkgs-fmt # Nix fmt
      rust-analyzer # Rust
      fsautocomplete # F#
      omnisharp-roslyn # C#
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

  home.file = {
    ".config/nvim".source = mkSymlink "${homeDir}/cfg/nvim";

    ".config/libnvimcfg.so".source = "${inputs.libnvimcfg.packages.${pkgs.system}.default}/lib/libnvimcfg.so";

    ".config/nvim-plugins".source =
      let
        packDir = pkgs.vimUtils.packDir config.programs.neovim.finalPackage.passthru.packpathDirs;
      in
      mkSymlink "${packDir}/pack/myNeovimPackages/start";

    ".config/nvim-treesitter-parsers".source =
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
