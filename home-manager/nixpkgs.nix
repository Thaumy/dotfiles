{ inputs, ... }: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
      ];
    };
    overlays = [ inputs.nur.overlay ];
  };
}
