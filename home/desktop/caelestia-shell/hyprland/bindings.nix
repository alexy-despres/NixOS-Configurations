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
        "$mod, X, global, caelestia:session" # Powermenu
        "$shiftMod, L, exec, hyprlock" # Lock (using hyprlock)
        # "$shiftMod, L, global, caelestia:lock" # Lock (using caelestia's built in lock)

        # Quick menu
        (
          "$shiftMod, X, exec, "
          + lib.getExe (mkMenu [
            {
              key = "q";
              desc = "quit";
              cmd = "echo quitting..."; # Doesn't actually do anything
            }
            {
              key = "s";
              desc = "Suspend";
              cmd = "systemctl suspend";
            }
            {
              key = "r";
              desc = "Reboot";
              cmd = "systemctl reboot";
            }
            {
              key = "p";
              desc = "Power Off";
              cmd = "systemctl poweroff";
            }
            {
              key = "n";
              desc = "Nightshift";
              cmd = "nightshift-toggle";
            }
          ])
        )

        # Quick launch
        "$mod, RETURN, exec, uwsm app -- ${pkgs.ghostty}/bin/ghostty" # Ghostty (terminal)
        "$mod, T, exec, uwsm app -- ${pkgs.kitty}/bin/kitty" # Kitty (terminal)
        "$mod, E, exec,  uwsm app -- ${pkgs.thunar}/bin/thunar" # Thunar
        "$shiftMod, E, exec, pkill fuzzel || caelestia emoji -p" # Emoji picker
        "$mod, SPACE, global, caelestia:launcher" # Launcher
        "$mod, N, exec, caelestia shell drawers toggle sidebar" # Sidebar (Notifications, quick actions)
        "$mod, W, exec, uwsm app -- zen-beta"

        # Special workspaces
        "$mod, D, exec, caelestia toggle communication" # Discord
        "CONTROL SHIFT, ESCAPE, exec, caelestia toggle sysmon" # Btop
        "$mod, M, exec, caelestia toggle music" # Spotify
        "$mod, G, exec, caelestia toggle github" # Github
        "$mod, O, exec, caelestia toggle notes" # Obsidian

        # Windows
        "$mod,Q, killactive," # Close window
        "$mod,F, fullscreen" # Toggle Fullscreen
        "$shiftMod, F, togglefloating," # Toggle Floating

        # Focus Windows
        "$mod,H, movefocus, l" # Move focus left
        "$mod,J, movefocus, d" # Move focus Down
        "$mod,K, movefocus, u" # Move focus Up
        "$mod,L, movefocus, r" # Move focus Right

        # For multiple monitors
        "$shiftMod, J, layoutmsg, removemaster" # Remove from master
        "$shiftMod, K, layoutmsg, addmaster" # Add to master

        # Utilities
        "$shiftMod, SPACE, exec, caelestia shell gameMode toggle" # Toggle Focus/Game mode
        "$shiftMod, S, global, caelestia:screenshotFreeze" # Capture region (freeze)
        "$shiftMod+Alt, S, global, caelestia:screenshot" # Capture region
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
      ", XF86MonBrightnessUp, global, caelestia:brightnessUp"
      ", XF86MonBrightnessDown, global, caelestia:brightnessDown"

      # Media
      ", XF86AudioPlay, global, caelestia:mediaToggle"
      ", XF86AudioPause, global, caelestia:mediaToggle"
      ", XF86AudioNext, global, caelestia:mediaNext"
      ", XF86AudioPrev, global, caelestia:mediaPrev"
      ", XF86AudioStop, global, caelestia:mediaStop"

      # Sound
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioRaiseVolume, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    ];

    bindin = [
      # Launcher
      "$mod, mouse:272, global, caelestia:launcherInterrupt"
      "$mod, mouse:273, global, caelestia:launcherInterrupt"
      "$mod, mouse:274, global, caelestia:launcherInterrupt"
      "$mod, mouse:275, global, caelestia:launcherInterrupt"
      "$mod, mouse:276, global, caelestia:launcherInterrupt"
      "$mod, mouse:277, global, caelestia:launcherInterrupt"
      "$mod, mouse_up, global, caelestia:launcherInterrupt"
      "$mod, mouse_down, global, caelestia:launcherInterrupt"
    ];
  };
}
