{ ... }:
let
  base = path: "org/gnome/nautilus${path}";
in
{
  dconf.settings.${base "/list-view"}.default-visible-columns = [
    "name"
    "size"
    "date_modified"
    "type"
  ];
}

