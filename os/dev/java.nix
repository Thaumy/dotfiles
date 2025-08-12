{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      jdk8
      jdk11
      jdk17
    ];

    etc = with pkgs; {
      "sdk-homes/jdk8".source = jdk8;
      "sdk-homes/jdk-11".source = jdk11;
      "sdk-homes/jdk-17".source = jdk17;
    };
  };
}
