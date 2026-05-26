{
  inputs = {
    pkgs.url = "github:NixOS/nixpkgs/295c3f1c2ac1a55504373727cd6cafb26fb6b047"; # 26-5-23

    nur.url = "github:nix-community/nur/797a5b4d04ae501c69eb54cadf7e526c1acad3fa"; # 26-2-14

    hm = {
      url = "github:nix-community/home-manager/509ed3c603349a9d43de9e2ae6613baea6bd5b34"; # 26-5-23
      inputs.nixpkgs.follows = "pkgs";
    };

    dae.url = "github:daeuniverse/flake.nix/62d55a8172c5ec028b21d50ea54c7c73107db6aa"; # 26-2-20

    rust-overlay = {
      url = "github:oxalica/rust-overlay/d9f52b51548e76ab8b6e7d647763047ebdec835c"; # 26-3-30
      inputs.nixpkgs.follows = "pkgs";
    };
    rsbin.url = "path:./rsbin";

    nvim.url = "github:nix-community/neovim-nightly-overlay/857c4b359c105ad56822e64fd35f9bf9f7947d70"; # 26-5-26
    libnvimcfg.url = "path:./nvim/lib";
  };

  outputs = inputs: {
    nixosConfigurations."nixos" = inputs.pkgs.lib.nixosSystem {
      modules = [ ./os/mod.nix ];
      specialArgs = { inherit inputs; };
    };

    homeConfigurations."thaumy" = inputs.hm.lib.homeManagerConfiguration {
      pkgs = import inputs.pkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      extraSpecialArgs = { inherit inputs; };
      modules = [ ./hm/mod.nix ];
    };
  };
}
