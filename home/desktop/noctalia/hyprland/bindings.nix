{
  pkgs,
  lib,
  config,
  ...
}: let
  colors = config.lib.stylix.colors;

  mkMenu = menu: let
    configFile = pkgs.writeText "config.yaml" (
      lib.generators.toYAML {} {
        anchor = "bottom-right";
        border = "#${colors.base0D}80";
        background = "#${colors.base01}EE";
        color = "#${colors.base05}";
        margin_right = 15;
        margin_bottom = 15;
        rows_per_column = 5;

        inherit menu;
      }
    );
  in
    pkgs.writeShellScriptBin "menu" ''
      exec ${lib.getExe pkgs.wlr-which-key} ${configFile}
    '';
in {
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    "$shiftMod" = "SUPER_SHIFT";

    bind =
      [
        "$mod, X, exec, noctalia msg panel-toggle session" # Powermenu
        "$shiftMod, L, exec, noctalia msg session lock" # Lock

        # Quick launch
        "$mod, RETURN, exec, uwsm app -- ${pkgs.ghostty}/bin/ghostty" # Ghostty (terminal)
        "$mod, T, exec, uwsm app -- ${pkgs.kitty}/bin/kitty" # Kitty (terminal)
        "$mod, E, exec,  uwsm app -- ${pkgs.thunar}/bin/thunar" # Thunar
        "$mod, SPACE, exec, noctalia msg panel-toggle launcher" # Launcher
        "$shiftMod, P, exec, noctalia msg panel-toggle noctalia/mpvpaper:picker" # Wallpaper picker
        "$mod, P, exec, noctalia msg panel-toggle wallpaper" # Wallpaper picker
        "$mod, N, exec, noctalia msg panel-toggle control-center notifications" # Sidebar (Notifications, quick actions)
        "$mod, W, exec, uwsm app -- zen-beta"

        "$mod, D, exec, sh -c 'hyprctl clients -j | grep -q \"\\\"class\\\": \\\"discord\\\"\" || uwsm app -- discord; hyprctl dispatch togglespecialworkspace communication'" # Special workspaces
        # "$mod, D, exec, uwsm app -- discord" # Discord is weird so we do it differently
        # "$mod, D, togglespecialworkspace, communication"

        "$mod, G, exec, pypr toggle github" # Github
        "CONTROL SHIFT, ESCAPE, exec, pypr toggle sysmon" # Btop
        "$mod, S, exec, pypr toggle music" # Spotify
        "$mod, M, exec, pypr toggle mail" # Proton mail
        "$mod, V, exec, pypr toggle vpn" # Proton mail
        "$mod, O, exec, pypr toggle notes" # Obsidian

        # Windows
        "$mod,Q, killactive," # Close window
        "$mod,F, fullscreen" # Toggle Fullscreen
        "$shiftMod, F, togglefloating," # Toggle Floating
        "$shiftMod, N, exec, nightshift-toggle" # Nightshift

        # Focus Windows
        "$mod,H, movefocus, l" # Move focus left
        "$mod,J, movefocus, d" # Move focus Down
        "$mod,K, movefocus, u" # Move focus Up
        "$mod,L, movefocus, r" # Move focus Right

        # For multiple monitors
        "$shiftMod, J, layoutmsg, removemaster" # Remove from master
        "$shiftMod, K, layoutmsg, addmaster" # Add to master
        # "$shiftMod, H, focusmonitor, -1" # Focus previous monitor
        # "$shiftMod, L, focusmonitor, 1" # Focus next monitor

        # Utilities
        "$shiftMod, S, exec, noctalia msg screenshot-fullscreen" # Capture region (freeze)
        "$shiftMod+Alt, S, exec, noctalia msg screenshot-region" # Capture region
      ]
      # Move/Change workspaces
      ++ (builtins.concatLists (
        builtins.genList (
          i: let
            ws = i + 1;
          in [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT,code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        )
        9
      ));

    # For floating windows
    bindm = [
      "$mod, mouse:272, movewindow" # Move Window (mouse)
      "$mod, R, resizewindow" # Resize Window (mouse)
    ];

    # Keyboard functions
    bindl = [
      # Brightness
      ", XF86MonBrightnessUp, exec, noctalia msg brightness-up"
      ", XF86MonBrightnessDown, exec, noctalia msg brightness-down"

      # Sound
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioRaiseVolume, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    ];
  };
}
