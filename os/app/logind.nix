_: {
  services.logind.settings.Login = {
    # don’t shutdown when power button is short-pressed
    HandlePowerKey = "ignore";
  };
}
