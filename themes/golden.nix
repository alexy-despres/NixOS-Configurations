{
  lib,
  pkgs,
  config,
  ...
}: let
  wallpaper-src = pkgs.fetchFromGitHub {
    owner = "mylinuxforwork";
    repo = "wallpaper";
    rev = "c2daf5305943861099a950fc370be48007a1a31c"; # or use a specific commit hash for reproducibility
    sha256 = "sha256-a3GwidRDy8Ke2V5EHwHEZr1smSgNG3N70faZ2lCrmnw=";
  };
in {
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
    };
    description = "Theme configuration options";
  };

  config.stylix = {
    enable = true;

    # See https://tinted-theming.github.io/tinted-gallery/ for more schemes
    base16Scheme = {
      # Base16 Tomorrow Night
      base00 = "1d1f21"; # Background
      base01 = "282a2e"; # Surface
      base02 = "373b41"; # Surface variant
      base03 = "969896"; # Comments/outlines
      base04 = "b4b7b4"; # Dim text
      base05 = "c5c8c6"; # Main text
      base06 = "e0e0e0"; # Bright text
      base07 = "ffffff"; # Brightest
      base08 = "cc6666"; # Red
      base09 = "de935f"; # Orange
      base0A = "f0c674"; # Yellow
      base0B = "b5bd68"; # Green
      base0C = "8abeb7"; # Cyan/Teal
      base0D = "81a2be"; # Blue
      base0E = "b294bb"; # Purple
      base0F = "a3685a"; # Brown
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
        applications = 13;
        desktop = 13;
        popups = 13;
        terminal = 13;
      };
    };

    polarity = "dark";

    image = "${wallpaper-src}/amber-island.jpg";
  };
}
