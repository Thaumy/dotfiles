{ ... }: {
  imports = [
    ./custom-key-bindings.nix
    ./gnome-terminal.nix
    ./interface.nix
    ./legacy-key-bindings.nix
    ./nautilus.nix
    ./power.nix
    ./system-proxy.nix
    ./wm-preferences.nix
  ];
}
