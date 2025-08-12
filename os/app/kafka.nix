{ pkgs, ... }: {
  services.apache-kafka.enable = true;

  environment = {
    systemPackages = [ pkgs.kafkactl ];
    etc."app-homes/kafka".source = pkgs.apacheKafka_3_2;
  };
}
