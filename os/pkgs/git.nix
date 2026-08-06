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
      rev = "d3db84fba8d3760dd281ed244d84996ddd08961e";
      hash = "sha256-Mlr2wWlc1tS8Y1liLy6iVQMf8dvqdTQS5WNKDQVa71Y=";
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
