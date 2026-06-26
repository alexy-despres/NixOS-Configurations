{
  pkgs,
  config,
  ...
}: let
  inherit (config.theme) bar-rounding bar-thickness;
  inherit (config.stylix) fonts;
in {
  home.packages = with pkgs; [
    papirus-icon-theme
  ];

  programs.caelestia.settings = {
    paths.sessionGif = ./session-gif-hacker-cat.gif;
    appearance = {
      transparency = {
        enabled = true;
        base = 0.75;
        layers = 0.6;
      };
      font.family = {
        material = "Material Symbols Rounded";
        mono = fonts.monospace.name;
        sans = fonts.sansSerif.name;
      };
    };
    utilities = {
      enabled = true;
      maxToasts = 4;
      toasts = {
        audioInputChanged = false;
        audioOutputChanged = false;
        capsLockChanged = false;
        chargingChanged = true;
        configLoaded = false;
        dndChanged = true;
        gameModeChanged = true;
        numLockChanged = false;
        nowPlaying = false;
        kbLayoutChanged = false;
      };
    };
    dashboard.showOnHover = true;
    border = {
      rounding = bar-rounding;
      thickness = bar-thickness;
    };
  };
}
