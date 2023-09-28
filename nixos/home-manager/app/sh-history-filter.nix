{ config, pkgs, ... }:

{

  home.file."shf.toml" = {
    enable = true;
    text = ''
      [output]
      dedup = true
      
      [predicate]
      regex = [
        "^$",
        "^#.+",
        "--help",
      
        "^sr .+",
        "^rm( -rf)? .+",
        "^.* /nix/store/.+",
        "^gsettings set .+ .+",
        ''''^.* /dev/shm/tmp\..+'''',
      
        "^docker( .+)+ .{64}",
        "^docker logs [0-9a-z]{12,16}",
        "^vi /var/lib/docker/containers/.+",
        "^vi admin:///var/lib/docker/containers/.+",
      
        "^git rm .+",
        "^git reset .+",
        "^git revert .+",
        "^git remote .+",
        "^git checkout .+",
        "^git submodule (add|remove) .+",
        "^git( |-)filter-repo --path .+",
        "^git( |-)filter-repo --path-regex .+",
      
        "^npm i .+@.+",
        "^cargo add .+@.+",
      
        "^ping .+",
        "^curl .+",
        "^wget .+",
        "^xdg-open .+",
        "^nix-shell -p .+",
        "^nix-prefetch-.+ .+",
      
        "^tokei .+",
        "^sudo systemctl status .+",
      
        "^adb install .+",
        "^adb shell sh .+",
      ]
    '';
  };

}
