{
  inputs = {
    nur.url = "github:nix-community/nur/9edb05163b86238999c6f6cab06c193e4de951f8"; # 24-6-12
    pkgs.url = "github:NixOS/nixpkgs/55dbedb9590009e44aa4b1844754700dd5d722e4"; # 24-7-1

    hyprland = {
      url = "git+https://github.com/hyprwm/hyprland?submodules=1&rev=1d70962892a6e3e1cacd3663b390bbdf81426984"; # 24-6-25
      inputs.nixpkgs.follows = "pkgs";
      inputs.hyprutils.url = "github:hyprwm/hyprutils/6174a2a25f4e216c0f1d0c4278adc23c476b1d09"; # 24-7-10
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
