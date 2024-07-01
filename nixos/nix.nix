{ ... }: {
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://cache.nixos.org/"
    ];
    trusted-public-keys = [
      "thaumy.cachix.org-1:aUhbtORDWI0e/T/FcTMezJc0S7IO9mT1IE84cXHNm14="
    ];
  };
  nix.optimise = {
    automatic = true;
    dates = [ "12:30" ];
  };
}
