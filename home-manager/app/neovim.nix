{ config, pkgs, ... }:
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
in
{
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      # neovim infrastructures
      plenary-nvim # async lib
      nvim-bufdel # better buffer delete

      # colorizers or signs
      nvim-web-devicons # icons
      catppuccin-nvim # color scheme
      rainbow-delimiters-nvim # colorful delimiters
      indent-blankline-nvim # indent lines
      nvim-colorizer-lua # color text hl
      todo-comments-nvim # TODOs hl
      gitsigns-nvim # gutter git signs
      nvim-ufo # code block folding

      # user interfaces
      markdown-preview-nvim # markdown renderer
      lualine-nvim # status line
      neo-tree-nvim # file explorer
      bufferline-nvim # buffer tabs
      nvim-notify # notify boxes, [noice-nvim:dep]
      noice-nvim # notice
      toggleterm-nvim # terminal

      # analyzers
      nvim-cmp # code completion
      cmp-path # path completion source
      cmp-buffer # buffer completion source
      cmp-cmdline # cmdline completion source
      cmp-nvim-lsp # lsp completion source
      nvim-treesitter.withAllGrammars # language parser
      nvim-lspconfig # lsp support
      Ionide-vim # F# lsp support

      # input helpers
      luasnip # snippet
      autoclose-nvim # auto close pairs and brackets
      nvim-comment # apply comment block
      neoformat # formatter
    ];

    extraPackages = with pkgs; [
      nil
      sqls
      deno
      gopls
      taplo # TOML
      fantomas # F# formatter
      marksman
      #typst-lsp
      nixpkgs-fmt
      rust-analyzer
      fsautocomplete
      omnisharp-roslyn
      jdt-language-server
      lua-language-server
      nodePackages.pyright
      kotlin-language-server
      nodePackages.bash-language-server
      nodePackages.yaml-language-server
      haskellPackages.haskell-language-server
      nodePackages.vscode-langservers-extracted
    ];
  };

  home.file.".config/nvim" = {
    enable = true;
    source = mkSymlink "${homeDir}/cfg/neovim";
  };
}
