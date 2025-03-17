{ ... }: {
  imports = [
    ./nix.nix
    ./coq.nix
    ./web.nix
    ./rust.nix
    ./java.nix
    ./llvm.nix
    ./dotnet.nix
  ];
}
