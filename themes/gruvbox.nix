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
      wallpaper = "/home/alexy/Pictures/Wallpapers/space.webm"; # For mpvpaper
    };
    description = "Theme configuration options";
  };

  config.stylix = {
    enable = true;

    # See https://tinted-theming.github.io/tinted-gallery/ for more schemes
    base16Scheme = {
      base00 = "1b1b1b"; # darkest bg
      base01 = "2b2b2b"; # dark
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
      # base02 = "262626"; # dark bg selected
      # base03 = "777777"; # comments / muted
      # base04 = "bdae93"; # light bg
      # base05 = "ddc7a1"; # default fg
      # base06 = "ebdbb2"; # light fg
      # base07 = "fbf1c7"; # lightest fg
      # base08 = "ea6962"; # red
      # base09 = "e78a4e"; # orange
      # base0A = "d8a657"; # yellow
      # base0B = "a9b665"; # green
      # base0C = "89b482"; # aqua/cyan
      # base0D = "7daea3"; # blue
      # base0E = "d3869b"; # purple/pink
      # base0F = "bd6f3e"; # brown/orange alt
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
