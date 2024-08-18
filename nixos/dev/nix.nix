{ pkgs, ... }: {
  nix = {
    settings = {
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      ];
      trusted-public-keys = [
        "thaumy.cachix.org-1:aUhbtORDWI0e/T/FcTMezJc0S7IO9mT1IE84cXHNm14="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      experimental-features = [
        "flakes"
        "nix-command"
      ];
    };
    optimise = {
      automatic = true;
      dates = [ "Mon..Fri 12:30" ];
    };
  };
  environment.systemPackages = with pkgs; [
    yarn2nix
    nix-index
    nix-prefetch-github
    nix-prefetch-scripts
  ];
}
