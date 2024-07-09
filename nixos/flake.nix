{
  inputs = {
    nur.url = "github:nix-community/nur/9edb05163b86238999c6f6cab06c193e4de951f8"; # 24-6-12
    pkgs.url = "github:NixOS/nixpkgs/8b89e34d1b10c0eb8bac6f2cc7b7a941f4acb171"; # 24-6-1
    hyprland = {
      url = "git+https://github.com/hyprwm/hyprland?submodules=1&rev=d1340bd1d8eedd274283e0cb2568a3ed67b58c81"; # 24-6-17
      inputs.nixpkgs.follows = "pkgs";
      inputs.hyprcursor.url = "github:hyprwm/hyprcursor/57298fc4f13c807e50ada2c986a3114b7fc2e621"; # 0.1.9
      inputs.hyprwayland-scanner.url = "github:hyprwm/hyprwayland-scanner/0f30f9eca6e404130988554accbb64d1c9ec877d"; # 0.3.10
    };
    rust-overlay.url = "github:oxalica/rust-overlay/fb8c8be0313f0e6385b3d70151a04ea1d71e4b68"; # 24-7-14
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
