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
      rev = "47499d0fa33f46c8e10ba5395712b364acf9bed5";
      hash = "sha256-TF8mgVrw7KMswWkICVWpDCbrVLM8xzjGtAZTWAwjaGw=";
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
      hash = "sha256-DYUlLNxWn4sn7PBir/miJUoDVAQ2/nbOVGWSGN+IPxw=";
    };
  }))
]
