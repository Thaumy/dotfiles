{ lib, inputs, config, pkgs, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;

  nvim-web-devicons = pkgs.vimUtils.buildVimPlugin {
    pname = "nvim-web-devicons";
    version = "2024-10-15";
    src = pkgs.fetchFromGitHub {
      owner = "Thaumy";
      repo = "nvim-web-devicons";
      rev = "d173154c3dd49336751281e4765bcee27a123cf9";
      hash = "sha256-BLk1xKbLMHq6tpaUf79GS2LMKHlphju6lGUkaQ/DHZc=";
    };
  };
in
{
  nixpkgs.overlays = [ inputs.nvim-nightly-overlay.overlays.default ];

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
      toggleterm-nvim # terminal
      actions-preview-nvim # code actions preview
      markdown-preview-nvim # markdown renderer

      # analyzers
      nvim-cmp # code completion, [deps: cmp-path, cmp-buffer, cmp-cmdline, cmp-nvim-lsp, luasnip, nvim-lspconfig]
      cmp-path # path completion source
      cmp-buffer # buffer completion source
      Ionide-vim # F# lsp support
      cmp_luasnip # luasnip completion source
      cmp-cmdline # cmdline completion source
      cmp-nvim-lsp # lsp completion source
      cmp-nvim-lua # nvim lua APIs completion source
      nvim-lspconfig # lsp support
      nvim-treesitter.withAllGrammars # language parser

      # input helpers
      luasnip # snippet
      neoformat # formatter
      crates-nvim # crate.io cmp
      comment-nvim # better comment support
      autoclose-nvim # auto close pairs and brackets
    ];

    extraPackages = with pkgs; [
      nil # nix
      ruff # py fmt
      sqls
      deno
      shfmt
      gopls
      taplo # toml
      pyright
      fantomas # fs fmt
      marksman
      tinymist # typst
      nixpkgs-fmt
      rust-analyzer
      fsautocomplete
      omnisharp-roslyn
      jdt-language-server
      lua-language-server
      bash-language-server
      yaml-language-server
      kotlin-language-server
      haskell-language-server
      vscode-langservers-extracted
    ];
  };

  home.file = {
    ".config/nvim" = {
      enable = true;
      source = mkSymlink "${homeDir}/cfg/neovim";
    };

    ".config/nvim-plugins" =
      let
        packDir = pkgs.vimUtils.packDir config.programs.neovim.finalPackage.passthru.packpathDirs;
      in
      {
        enable = true;
        source = mkSymlink "${packDir}/pack/myNeovimPackages/start";
      };

    ".config/nvim-treesitter-parsers" =
      let
        nvim-treesitter-parsers = pkgs.symlinkJoin {
          name = "nvim-treesitter-parsers";
          paths = pkgs.vimPlugins.nvim-treesitter.withAllGrammars.dependencies;
        };
      in
      {
        enable = true;
        source = mkSymlink nvim-treesitter-parsers;
      };
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
