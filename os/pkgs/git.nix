{ pkgs, ... }: with pkgs; [
  gh
  git
  git-lfs
  gitoxide
  git-filter-repo

  (github-desktop.overrideAttrs (_: finalAttrs: {
    src = fetchFromGitHub {
      owner = "Thaumy";
      repo = "guthib-desktop";
      rev = "43ed8e5fbc4fb7bdd3e19ce8447c727dff05908d";
      hash = "sha256-ThNyHhBo0b4H7NXw582cVPHNndxu9GY/ozWQGTQmHm8=";
      fetchSubmodules = true;
      postCheckout = "git -C $out rev-parse HEAD > $out/.gitrev";
    };
    cacheRoot = fetchYarnDeps {
      name = "${finalAttrs.pname}-cache-root";
      yarnLock = finalAttrs.src + "/yarn.lock";
      hash = "sha256-OJDxq1Yep3swLU87YyJz7WfpPzpxo5ISukB4pIwxJBA=";
    };
    cacheApp = fetchYarnDeps {
      name = "${finalAttrs.pname}-cache-app";
      yarnLock = finalAttrs.src + "/app/yarn.lock";
      hash = "sha256-9IWvtItxY6eUa8APuVw5xspSU0BDmtqV+KmUvQYsAeI=";
    };
  }))
]
