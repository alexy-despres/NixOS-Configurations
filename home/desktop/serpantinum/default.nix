{inputs, ...}: {
  imports = [
    inputs.serpantinum.homeManagerModules.default
    ./hyprland
    ./stylix.nix
  ];

  wayland.windowManager.hyprland.settings.exec-once = ["serpantinumd start"];

  programs.serpantinum = {
    enable = true;
    systemd.enable = true;

    settings = {
      wallpaperDir = "/home/alexy/Wallpapers/Images";

      general = {
        language = "en";
        weatherUnit = "metric";
        weatherInterval = 30;
        muteSfx = true;
        sfxVolume = 0;
      };

      bar = {
        position = "top";
        style = "solid";
        width = 75;
        opacity = 85;
        workspaceCount = 9;
        modules = {
          left = ["workspaces" "media"];
          center = ["visualizer"];
          right = ["tray" ["kb" "time" "wifi" "bt" "vol" "bat"]];
        };
      };

      theme = {
        fontFamily = "Adwaita Mono";
        borderRadius = 16;
        matugen = true;
      };

      notifications = {
        dnd = false;
        position = "top right";
        sound = false;
      };
    };
  };
}
