{ ... }:
let
  base = path: "system/proxy${path}";
in
{
  dconf.settings = {
    ${base ""} = {
      ignore-hosts = [ "localhost" "127.0.0.0/8" "::1" ];
      mode = "manual";
    };

    ${base "/http"} = {
      host = "localhost";
      port = 7890;
    };

    ${base "/socks"} = {
      host = "localhost";
      port = 7891;
    };
  };
}
