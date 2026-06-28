{config, ...}: let
  wallpaper = config.theme.wallpaper;
in {
  programs.mpvpaper = {
    enable = true;
  };

  wayland.windowManager.hyprland.settings.exec-once = [
    "mpvpaper -o \"no-audio loop hwdec=vaapi\" eDP-1 ${wallpaper}"
  ];

  programs.mpv = {
    enable = true;

    config = {
      "video-aspect-override" = "16:10";
    };
  };
}
