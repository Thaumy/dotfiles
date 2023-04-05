{ config, pkgs, ... }:

let
  stable-pkgs = import <nixos-22.11> { config = { allowUnfree = true; }; };
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

    plugins = with pkgs.vimPlugins;[

      catppuccin-nvim
      #(catppuccin-nvim.overrideAttrs (_: {
      #  patches = [
      #    (pkgs.fetchpatch { url = "https://github.com/catppuccin/nvim/pull/414/commits/bfe533cb9c42c776a802f8f7802182b5fbf0876a.patch"; sha256 = "sha256-rxhpAJqXBp2rbAHqzyXGadr7zgYChafgaPDa4EpBaPA="; })
      #    (pkgs.fetchpatch { url = "https://github.com/catppuccin/nvim/pull/414/commits/589571e86cc93b67023efe59ad74fc7fe9dc5d37.patch"; sha256 = "sha256-I+whdbdWj7OgNU16UNTl5CHPy6HqBVqiNpGgVgluBOg="; })
      #  ];
      #}))

      suda-vim
      neoformat
      Ionide-vim
      lualine-nvim
      nvim-tree-lua
      nvim-lspconfig
      nvim-colorizer-lua
      markdown-preview-nvim
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

    extraPackages = with pkgs;[
      sqls
      deno
      gopls
      taplo
      rnix-lsp
      marksman
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
