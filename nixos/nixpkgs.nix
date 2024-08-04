args@{ ... }: {
  nixpkgs = {
    config.allowUnfree = true;
    overlays = (import ./overlay/mod.nix) args;
  };
}
