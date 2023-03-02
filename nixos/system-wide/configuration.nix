{ config, pkgs, ... }:

{

  imports = [
    ./boot.nix
    ./hardware-configuration.nix
    ./local.nix
    ./networking.nix
    ./pkgs.nix

    ./app/clash.nix
    ./app/fish.nix
    ./app/mysql.nix
    ./app/postgres.nix
    ./app/steam.nix
    ./app/yubikey.nix
  ];

  environment = {
    localBinInPath = true;
    variables = { EDITOR = "nvim"; };
    sessionVariables = {
      # NIXOS_OZONE_WL = "1";
      DOTNET_ROOT = "${pkgs.dotnet-sdk_7}";
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.thaumy = {
    description = "Thaumy";
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  hardware = {
    opengl.enable = true;
    nvidia.modesetting.enable = true;
    nvidia.package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  systemd.services = {
    # Workaround for GNOME autologin:
    # https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
    "getty@tty1".enable = false;
    "autovt@tty1".enable = false;
  };

  services = {

    xserver = {
      enable = true;

      # Configure keymap in X11
      layout = "us";
      xkbVariant = "";

      # Enable the GNOME Desktop Environment.
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;

      # Enable automatic login for the user.
      displayManager.autoLogin.enable = true;
      displayManager.autoLogin.user = "thaumy";

      # Enable touchpad support (enabled default in most desktopManager).
      # libinput.enable = true;

      dpi = 180;
      videoDrivers = [ "nvidia" ];
      excludePackages = [ pkgs.xterm ];
    };

    # Enable CUPS to print documents.
    printing.enable = true;

  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  nixpkgs = {
    overlays = [
      (import ./overlay/rust.nix)
      # (import ./overlay/vscode.nix)
      # (import ./overlay/neovim.nix)
      (import ./overlay/chromium.nix)
    ];

    config.allowUnfree = true;
    config.packageOverrides = pkgs: {
      nur = import
        (builtins.fetchTarball
          "https://github.com/nix-community/NUR/archive/master.tar.gz")
        {
          inherit pkgs;
        };
    };
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://cache.nixos.org/"
    ];
  };

}
