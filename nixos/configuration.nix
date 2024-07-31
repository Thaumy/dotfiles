{ pkgs, ... }: {
  imports = [
    ./nix.nix
    ./sec.nix
    ./boot.nix
    ./user.nix
    ./pkgs.nix
    ./local.nix
    ./nixpkgs.nix
    ./app/mod.nix
    ./hardware.nix
    ./programs.nix
    ./services.nix
    ./networking.nix
    ./hardware-configuration.nix
  ];

  powerManagement.enable = true;

  services.logind.extraConfig = ''
    # don’t shutdown when power button is short-pressed
    HandlePowerKey=ignore
  '';

  environment = {
    localBinInPath = true;
    sessionVariables = {
      DOTNET_ROOT = "${pkgs.dotnet-sdk_7}";
      SSH_AUTH_SOCK = "\${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh";
      LIBCLANG_PATH = "${pkgs.libclang.lib}/lib";
      NIXOS_OZONE_WL = "1";
      QT_SCALE_FACTOR = "1.6";
      QT_STYLE_OVERRIDE = "kvantum";
    };
  };

  #users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
