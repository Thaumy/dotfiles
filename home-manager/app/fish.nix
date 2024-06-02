{ config, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  programs.fish = {
    enable = true;

    shellAliases = {
      l = "eza -l --git -g --time-style '+%y.%m-%d %H:%M' -a --smart-group --group-directories-first";
      ls = "eza --no-permissions --no-filesize --no-user --no-time --group-directories-first";
      du = "dust";
      ps = "procs";
      cat = "bat --style numbers";
      q = "exit";
    };

    shellInit = ''
      export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
    '';

    interactiveShellInit = ''
      source ${homeDir}/cfg/fish/interactive.fish
    '';
  };

  home.file.".config/fish/functions" = {
    enable = true;
    source = mkSymlink "${homeDir}/cfg/fish/functions";
  };
}
