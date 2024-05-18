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
    ./networking.nix
    ./hardware-configuration.nix
  ];

  powerManagement.enable = true;

  services.logind.extraConfig = ''
    # don’t shutdown when power button is short-pressed
    HandlePowerKey=ignore
  '';

  virtualisation = {
    #lxd.enable = true;
    podman = {
      enable = true;

      defaultNetwork.settings = {
        dns_enabled = true;
      };
    };
    #virtualbox.host.enable = true;
  };

  environment = {
    localBinInPath = true;
    variables = {
      EDITOR = "nvim";
      QT_STYLE_OVERRIDE = "kvantum";
    };
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      DOTNET_ROOT = "${pkgs.dotnet-sdk_7}";
      LIBCLANG_PATH = "${pkgs.libclang.lib}/lib";
    };
  };

  #users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
