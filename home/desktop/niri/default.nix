{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    rofi
    swaybg
    swayidle
    swaylock
    nerd-fonts.jetbrains-mono
  ];

  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    theme = "gruvbox-dark";
  };

  programs.niri.settings = {
    input = {
      keyboard.xkb.layout = "us";
      touchpad = {
        tap = true;
        natural-scroll = true;
      };
    };

    layout = {
      gaps = 16;
      center-focused-column = "never";
      default-column-width = {proportion = 0.5;};
      focus-ring = {
        enable = true;
        width = 2;
        active.color = "#89b4fa";
      };
    };

    prefer-no-csd = true;

    # cursor = {
    #   xcursor-theme = "Adwaita";
    #   # xcursor-size = 24;
    # };

    # blur = {
    #   on = true;
    #   passes = 3;
    #   radius = 8.0;
    #   noise = 0.02;
    # };

    # window-rules = [
    #   {
    #     matches = [{app-id = "^com\\.mitchellh\\.ghostty$";}];
    #     # background-effect = {
    #     #   blur = true;
    #     #   xray = false;
    #     # };
    #     opacity = 0.92;
    #   }
    #   {
    #     matches = [{app-id = "^Rofi$";}];
    #     # background-effect.blur = true;
    #     opacity = 0.92;
    #   }
    #   {
    #     matches = [{app-id = "^org.pulseaudio.pavucontrol$";}];
    #     open-floating = true;
    #   }
    # ];

    # layer-rules = [
    #   {
    #     matches = [{namespace = "^waybar$";}];
    #     # background-effect = {
    #     #   blur = true;
    #     #   xray = false;
    #     # };
    #     geometry-corner-radius = {
    #       top-left = 12;
    #       top-right = 12;
    #       bottom-left = 12;
    #       bottom-right = 12;
    #     };
    #   }
    # ];

    binds = with config.lib.niri.actions; {
      "Mod+Return".action = spawn "ghostty";
      "Mod+D".action = spawn "rofi" "-show" "drun";
      "Mod+Q".action = close-window;
      "Mod+Shift+E".action = quit;
      "Mod+Shift+P".action = spawn "swaylock";

      # focus movement (scrolling columns)
      "Mod+Left".action = focus-column-left;
      "Mod+Right".action = focus-column-right;
      "Mod+Up".action = focus-window-up;
      "Mod+Down".action = focus-window-down;
      "Mod+H".action = focus-column-left;
      "Mod+L".action = focus-column-right;
      "Mod+K".action = focus-window-up;
      "Mod+J".action = focus-window-down;

      # move columns/windows
      "Mod+Shift+Left".action = move-column-left;
      "Mod+Shift+Right".action = move-column-right;
      "Mod+Shift+Up".action = move-window-up;
      "Mod+Shift+Down".action = move-window-down;

      # workspaces (vertical)
      "Mod+Page_Down".action = focus-workspace-down;
      "Mod+Page_Up".action = focus-workspace-up;
      "Mod+Shift+Page_Down".action = move-column-to-workspace-down;
      "Mod+Shift+Page_Up".action = move-column-to-workspace-up;

      "Mod+1".action = focus-workspace 1;
      "Mod+2".action = focus-workspace 2;
      "Mod+3".action = focus-workspace 3;
      "Mod+4".action = focus-workspace 4;
      # "Mod+Shift+1".action = move-column-to-workspace 1;
      # "Mod+Shift+2".action = move-column-to-workspace 2;
      # "Mod+Shift+3".action = move-column-to-workspace 3;
      # "Mod+Shift+4".action = move-column-to-workspace 4;

      # column sizing
      "Mod+R".action = switch-preset-column-width;
      "Mod+F".action = maximize-column;
      "Mod+Shift+F".action = fullscreen-window;
      "Mod+C".action = center-column;
      "Mod+V".action = toggle-window-floating;

      # screenshots
      # "Print".action = screenshot;
      # "Mod+Print".action = screenshot-window;

      # volume (pipewire/wireplumber)
      "XF86AudioRaiseVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+";
      "XF86AudioLowerVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-";
      "XF86AudioMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
    };

    spawn-at-startup = [
      {command = ["swaybg" "-i" "/home/alexy/Wallpapers/Images/dark-star.jpg"];}
      {command = ["swayidle" "-w" "timeout" "300" "swaylock"];}
    ];
  };
}
