{ inputs, pkgs, lib, ... }: {
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [ inputs.nur.overlays.default ];
  };

  environment.systemPackages = lib.flatten (map (path: pkgs.callPackage path { }) [
    ./im.nix
    ./git.nix
    ./top.nix
    ./tree.nix
    ./docs.nix
    ./text.nix
    ./media.nix
    ./browser.nix
    ./archive.nix
    ./meeting.nix
    ./blockchain.nix
  ]);
}
