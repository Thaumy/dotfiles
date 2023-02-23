{ config, pkgs, ... }:

let
  stable-pkgs = import <nixos-22.11> { config = { allowUnfree = true; }; };
in
{

  programs.neovim = {

    enable = true;

    viAlias = true;
    vimAlias = true;

    extraConfig = (builtins.readFile ~/cfg/neovim/rc);

    plugins = with pkgs.vimPlugins;[

      #catppuccin-nvim
	(catppuccin-nvim.overrideAttrs (_: {
	  patches = [
	    (pkgs.fetchpatch { url = "https://github.com/catppuccin/nvim/pull/414/commits/bfe533cb9c42c776a802f8f7802182b5fbf0876a.patch"; sha256 = "sha256-rxhpAJqXBp2rbAHqzyXGadr7zgYChafgaPDa4EpBaPA="; })
	    (pkgs.fetchpatch { url = "https://github.com/catppuccin/nvim/pull/414/commits/589571e86cc93b67023efe59ad74fc7fe9dc5d37.patch"; sha256 = "sha256-I+whdbdWj7OgNU16UNTl5CHPy6HqBVqiNpGgVgluBOg="; })
	  ];
	}))

      neoformat
      Ionide-vim
      nvim-lspconfig
      nvim-tree-lua
      lualine-nvim
      nvim-colorizer-lua
      nvim-treesitter.withAllGrammars

      stable-pkgs.vimPlugins.markdown-preview-nvim

      dashboard-nvim
      #"nvim-tree/nvim-web-devicons"

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
