{ config, pkgs, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
  pkgs-23-05 = import <nixos-23.05> { config = { allowUnfree = true; }; };
in
{
  home.file = {
    ".config/nvim/lua" = {
      enable = true;
      source = mkSymlink "${homeDir}/cfg/neovim/lua";
    };
    ".config/nvim/ftplugin" = {
      enable = true;
      source = mkSymlink "${homeDir}/cfg/neovim/ftplugin";
    };
  };

  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    extraConfig = ''
      set nocompatible
      "set autochdir

      " share system clipboard
      set clipboard+=unnamedplus

      luafile ~/cfg/neovim/init.lua
    '';

    plugins = with pkgs.vimPlugins; [
      bufferline-nvim # file tabs
      lualine-nvim
      neo-tree-nvim # file explorer

      #Ionide-vim
      nvim-lspconfig
      markdown-preview-nvim
      lightspeed-nvim
      formatter-nvim
      nvim-treesitter.withAllGrammars

      noice-nvim # notice
      nvim-notify # noice-nvim:dep
      dashboard-nvim # dashboard
      catppuccin-nvim # theme
      nvim-web-devicons # icons
      nvim-colorizer-lua

      gitsigns-nvim # git lines in gutter
      rainbow-delimiters-nvim # colorful delimiters
      indent-blankline-nvim # indent lines
      todo-comments-nvim # TODOs highlight
      plenary-nvim
      autoclose-nvim # auto pairs & closes brackets
      nvim-ufo # code folding

      nvim-bufdel # better buffer delete
      Ionide-vim
      nvim-cmp
      cmp-path
      cmp-vsnip
      vim-vsnip
      cmp-buffer
      cmp-cmdline
      cmp-nvim-lsp
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
}
