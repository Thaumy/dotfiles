{ pkgs, ... }: {
  environment = {
    systemPackages = [ pkgs.dotnet-sdk_7 ];
    etc."sdk-homes/dotnet".source = pkgs.dotnet-sdk_7;
  };
}
