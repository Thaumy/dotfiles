{ pkgs, ... }: {
  services.apache-kafka.enable = true;

  environment.etc = {
    "app-homes/kafka".source = pkgs.apacheKafka_3_2;
  };
}
