{
  inputs = {
    nur.url = "github:nix-community/nur";
    pkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hyprland.url = "git+https://github.com/hyprwm/hyprland?submodules=1";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = inputs@{ ... }: {
    nixosConfigurations."nixos" = inputs.pkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
      ];
    };
  };
}
