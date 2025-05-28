{ pkgs, pkgs-24-05, ... }: {
  home.packages = with pkgs; [
    # nur
    #nur.repos.thaumy.idbuilder
    nur.repos.thaumy.microsoft-todo-electron
    #nur.repos.xddxdd.dingtalk

    # penetration
    #mdk4

    # etc
    pkgs-24-05.postman
  ];
}
