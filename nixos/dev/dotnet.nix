{ pkgs, ... }: {
  environment = {
    systemPackages = [ pkgs.dotnet-sdk_7 ];
    etc."sdk-homes/dotnet".source = pkgs.dotnet-sdk_7;

    sessionVariables = {
      DOTNET_ROOT = pkgs.dotnet-sdk_7;
    };
  };
}
