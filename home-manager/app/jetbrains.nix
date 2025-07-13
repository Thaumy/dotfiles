{ pkgs-24-05, ... }: {
  home.packages = with pkgs-24-05; [
    #jetbrains.rider
    #jetbrains.clion
    #jetbrains.goland
    #jetbrains.webstorm
    #jetbrains.dataspell
    #jetbrains.rust-rover
    #jetbrains.idea-ultimate
    #jetbrains.pycharm-professional
  ];
}
