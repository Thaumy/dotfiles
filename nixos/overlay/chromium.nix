final: prev: {
  chromium = prev.chromium.override {
    commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
  };
}
