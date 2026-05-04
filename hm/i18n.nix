{ pkgs, ... }:
let
  bg_svg = pkgs.writeText "bg.svg" ''
    <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
      width="100" height="40" viewBox="0 0 100 40">
      <rect x="0" y="0" width="97" height="37"
        rx="8" style="fill:#000000;opacity:0.1" />
      <rect x="1" y="0.5" width="98" height="38"
        rx="9" style="fill:#000000;opacity:0.16" />
      <rect x="0.6" y="0.2" width="97" height="37"
        rx="8" style="fill:#f2f2f2" />
    </svg>
  '';
in
{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";

    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-gtk
        kdePackages.fcitx5-qt
        qt6Packages.fcitx5-chinese-addons
      ];

      themes."thaumy_light".theme = ''
        [Metadata]
        Name=Thaumy Light

        [InputPanel]
        NormalColor=#292929
        HighlightCandidateColor=#0a8be2

        [InputPanel/Background]
        Image=${bg_svg}

        [InputPanel/Background/Margin]
        Left=15
        Right=15
        Top=12
        Bottom=12

        [InputPanel/Highlight]
        Color=#f2f2f2

        [InputPanel/TextMargin]
        Left=9
        Right=9
        Top=4
        Bottom=6
      '';
    };
  };
}
