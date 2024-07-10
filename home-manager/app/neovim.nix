{ lib, inputs, config, pkgs, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;

  neo-tree-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "neo-tree.nvim";
    version = "2024-4-17";
    src = pkgs.fetchFromGitHub {
      owner = "Thaumy";
      repo = "neo-tree.nvim";
      rev = "aa14c0e3fed9cf3537e5cbfbe760c3d52fc8ea23";
      hash = "sha256-9frD77EauIcBz96msCzEWJVULXIdYyi4kEbrbYFOtWk=";
    };
  };
  catppuccin-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "catppuccin-nvim";
    version = "2024-6-9";
    src = pkgs.fetchFromGitHub {
      owner = "Thaumy";
      repo = "catppuccin-nvim";
      rev = "9ad2946e84e34122828ba38549134255342c2899";
      hash = "sha256-fLn+DS+g5ONcPVwXKcN+QQXMnDCo3yQ91gObH1ucnok=";
    };
  };
  nvim-web-devicons = pkgs.vimUtils.buildVimPlugin {
    pname = "nvim-web-devicons";
    version = "2024-6-15";
    src = pkgs.fetchFromGitHub {
      owner = "Thaumy";
      repo = "nvim-web-devicons";
      rev = "8fcd5985adb99003759bc031bf2f136add1780ee";
      hash = "sha256-2h+fAvBK2mjcncefzOhgGG3TWBXQDVhw/NHn9gp9MbE=";
    };
  };
in
{
  nixpkgs.overlays = [ inputs.nvim-nightly-overlay.overlays.default ];

  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

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
      fidget-nvim # notifications
      lualine-nvim # status line
      neo-tree-nvim # file explorer, [deps: plenary-nvim, nvim-web-devicons, nui-nvim]
      telescope-nvim # fuzzy finder
      bufferline-nvim # buffer tabs
      toggleterm-nvim # terminal
      markdown-preview-nvim # markdown renderer

      # analyzers
      nvim-cmp # code completion, [deps: cmp-path, cmp-buffer, cmp-cmdline, cmp-nvim-lsp, luasnip, nvim-lspconfig]
      cmp-path # path completion source
      cmp-buffer # buffer completion source
      Ionide-vim # F# lsp support
      cmp-cmdline # cmdline completion source
      cmp-nvim-lsp # lsp completion source
      nvim-lspconfig # lsp support
      nvim-treesitter.withAllGrammars # language parser

      # input helpers
      luasnip # snippet
      neoformat # formatter
      comment-nvim # better comment support
      autoclose-nvim # auto close pairs and brackets
    ];

    extraPackages = with pkgs; [
      nil
      sqls
      deno
      gopls
      taplo # TOML
      pyright
      fantomas # F# formatter
      marksman
      typst-lsp
      nixpkgs-fmt
      rust-analyzer
      fsautocomplete
      omnisharp-roslyn
      jdt-language-server
      lua-language-server
      kotlin-language-server
      nodePackages.bash-language-server
      nodePackages.yaml-language-server
      haskellPackages.haskell-language-server
      nodePackages.vscode-langservers-extracted
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

  # HACK: use `hiPrio` to override neovim wrapper
  home.packages = [
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
