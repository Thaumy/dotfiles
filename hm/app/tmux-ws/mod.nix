{ config, pkgs, ... }:
let
  main_sh = pkgs.writeTextFile {
    name = "main.sh";
    text = builtins.readFile ./main.sh;
  };
  prelude_sh = pkgs.writeTextFile {
    name = "prelude.sh";
    text = builtins.readFile ./prelude.sh;
  };
  tmux-ws = pkgs.writeScriptBin "ws" ''
    #!${pkgs.dash}/bin/dash
    export PRELUDE="${prelude_sh}"
    ${pkgs.dash}/bin/dash ${main_sh} "$@"
  '';

  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.packages = [ tmux-ws ];
  programs.fish.completions.ws = ''
    complete -c ws -f
    complete -c ws -n __fish_is_first_arg -a "(ws)" -f
  '';

  xdg.configFile."tmux-ws".source = mkSymlink "${homeDir}/cfg/tmux-ws";
}
