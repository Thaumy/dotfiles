{ ... }: {
  imports = [
    ./nix.nix
    ./coq.nix
    ./rust.nix
    ./node.nix
    ./java.nix
    ./dotnet.nix
  ];
}
