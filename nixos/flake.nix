{
  inputs = {
    nur.url = "github:nix-community/nur";
    pkgs.url = "github:NixOS/nixpkgs/8b89e34d1b10c0eb8bac6f2cc7b7a941f4acb171"; # 24-06-01
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
