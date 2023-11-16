{ pkgs, ... }:
let
  pkgs-23-05 = import <nixos-23.05> { config = { allowUnfree = true; }; };
in
{
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    extraConfig = ''
      set nocompatible

      " share system clipboard
      set clipboard+=unnamedplus

      luafile ~/cfg/neovim/init.lua
    '';

    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      Ionide-vim
      lualine-nvim
      nvim-tree-lua
      nvim-lspconfig
      formatter-nvim
      nvim-colorizer-lua
      markdown-preview-nvim
      lightspeed-nvim
      nvim-treesitter.withAllGrammars

      dashboard-nvim
      nvim-web-devicons

      todo-comments-nvim
      plenary-nvim

      nvim-cmp
      cmp-path
      cmp-vsnip
      vim-vsnip
      cmp-buffer
      cmp-cmdline
      cmp-nvim-lsp
    ];

    extraPackages = with pkgs; [
      sqls
      deno
      gopls
      taplo # TOML
      rnix-lsp
      marksman
      typst-lsp
      rust-analyzer
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
