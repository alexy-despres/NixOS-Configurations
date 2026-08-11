{
  lib,
  pkgs,
  config,
  ...
}: {
  options.theme = lib.mkOption {
    type = lib.types.attrs;
    default = {
      rounding = 30;
      bar-rounding = 20 + 10;
      bar-thickness = 0;
      gaps-in = 8;
      gaps-out = 8 * 2;
      active-opacity = 0.96;
      inactive-opacity = 0.92;
      blur = true;
      border-size = 2;
      animation-speed = "medium"; # "fast" | "medium" | "slow"
      fetch = "pfetch"; # "nerdfetch" | "neofetch" | "pfetch" | "none"
      wallpaper = "/home/alexy/Wallpapers/Videos/blackhole2.webm"; # For mpvpaper (caelestia)
    };
    description = "Theme configuration options";
  };

  config.stylix = {
    enable = true;

    # See https://tinted-theming.github.io/tinted-gallery/ for more schemes
    base16Scheme = {
      base00 = "1b1b1b";
      base01 = "2b2b2b";
      base02 = "222222";
      base03 = "333333";
      base04 = "999999";
      base05 = "c1c1c1";
      base06 = "999999";
      base07 = "c1c1c1";
      base08 = "5f8787";
      base09 = "aaaaaa";
      base0A = "8c7f70";
      base0B = "9b8d7f";
      base0C = "aaaaaa";
      base0D = "888888";
      base0E = "999999";
      base0F = "444444";
    };

    cursor = {
      name = "BreezeX-RosePine-Linux";
      package = pkgs.rose-pine-cursor;
      size = 20;
    };

    fonts = {
      monospace = {
        package = pkgs.maple-mono.NF;
        name = "Maple Mono NF";
      };
      sansSerif = {
        package = pkgs.source-sans-pro;
        name = "Source Sans Pro";
      };
      serif = config.stylix.fonts.sansSerif;
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 17;
        desktop = 20;
        popups = 13;
        terminal = 19;
      };
    };

    polarity = "dark";
  };
}
