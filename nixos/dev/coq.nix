{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    coq
    coqPackages.coqide
  ];
}
