{ config, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  programs.fish = {
    enable = true;

    shellAliases = {
      q = "exit";
      g = "git";
      c = "cargo";
      l = "eza -l --git -g --time-style '+%y-%m-%d %H:%M' -a --smart-group --group-directories-first";
      ls = "eza --no-permissions --no-filesize --no-user --no-time --group-directories-first";
      lc = ''cd "$(command lf -print-last-dir $argv)"'';
      du = "dust";
      ps = "procs";
      cat = "bat --style numbers";
      se = "sudo -E";
    };

    interactiveShellInit = ''
      source ${homeDir}/cfg/fish/interactive.fish
    '';
  };

  home.file.".config/fish/functions" = {
    enable = true;
    source = mkSymlink "${homeDir}/cfg/fish/functions";
  };
}
