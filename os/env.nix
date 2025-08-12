{ pkgs, ... }: {
  environment = {
    localBinInPath = true;
    sessionVariables = {
      SSH_AUTH_SOCK = "\${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh";
      LIBCLANG_PATH = "${pkgs.libclang.lib}/lib";
      NIXOS_OZONE_WL = "1";
      QT_SCALE_FACTOR = "1.6";
      QT_STYLE_OVERRIDE = "kvantum";
    };
  };
}
