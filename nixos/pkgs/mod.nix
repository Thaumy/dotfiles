{ inputs, pkgs, lib, ... }: {
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [ inputs.nur.overlays.default ];
  };

  environment.systemPackages = lib.flatten (map (path: pkgs.callPackage path { }) [
    ./im.nix
    ./git.nix
    ./docs.nix
    ./media.nix
    ./browser.nix
    ./meeting.nix
    ./blockchain.nix
  ]);
}
