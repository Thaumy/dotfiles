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
      rev = "c1a5a4a8123a14e638997728b470733bf925479e";
      hash = "sha256-tkp69NVAEJal3qLjoEsugJqRCtJT39z0gEm3IkkKI+Q=";
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
