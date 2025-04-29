{ inputs, pkgs, lib, ... }: {
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [ inputs.nur.overlays.default ];
  };

  environment.systemPackages = lib.flatten (map (path: pkgs.callPackage path { }) [
    ./media.nix
    ./browser.nix
    ./blockchain.nix
  ]);
}
