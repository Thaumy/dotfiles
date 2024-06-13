{
  inputs = {
    nur.url = "github:nix-community/nur/9edb05163b86238999c6f6cab06c193e4de951f8"; # 24-06-12
    pkgs.url = "github:NixOS/nixpkgs/8b89e34d1b10c0eb8bac6f2cc7b7a941f4acb171"; # 24-06-01
    hyprland = {
      url = "git+https://github.com/hyprwm/hyprland?submodules=1&rev=ea2501d4556f84d3de86a4ae2f4b22a474555b9f"; # 0.41.0
      inputs.nixpkgs.follows = "pkgs";
      inputs.hyprcursor.url = "github:hyprwm/hyprcursor/57298fc4f13c807e50ada2c986a3114b7fc2e621"; # 0.1.9
      inputs.hyprwayland-scanner.url = "github:hyprwm/hyprwayland-scanner/0f30f9eca6e404130988554accbb64d1c9ec877d"; # 0.3.10
    };
    rust-overlay.url = "github:oxalica/rust-overlay/4cbc2810d1dfb5960791be92df6a5f842a79bdfb"; # 24-06-13
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
