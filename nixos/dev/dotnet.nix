{ pkgs, ... }: {
  environment = {
    systemPackages = [ pkgs.dotnet-sdk_8 ];
    etc."sdk-homes/dotnet".source = pkgs.dotnet-sdk_8;

    sessionVariables = {
      DOTNET_ROOT = pkgs.dotnet-sdk_8;
    };
  };
}
