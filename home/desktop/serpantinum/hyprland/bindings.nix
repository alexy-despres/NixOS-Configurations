{pkgs, ...}: {
  home.file.".config/nixos/home/desktop/serpantinum/scripts/cycle-toggle.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      # Cycles through toggles on each press of SUPER+Tab

      STATE_FILE="/tmp/serpantinum_cycle_idx"
      COMMANDS=(
        "serpantinum msg toggle music"
        "serpantinum msg toggle calendar"
        "serpantinum msg toggle network"
      )

      # Read current index, default 0
      if [[ -f "$STATE_FILE" ]]; then
        idx=$(<"$STATE_FILE")
      else
        idx=0
      fi

      # Run the current command
      eval "''${COMMANDS[$idx]}"

      # Advance index (wrap around)
      next=$(( (idx + 1) % ''${#COMMANDS[@]} ))
      echo "$next" > "$STATE_FILE"
    '';
  };

  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    "$shiftMod" = "SUPER_SHIFT";

    bind =
      [
        "$mod, X, exec, serpantinum msg toggle guide" # Settings
        "$shiftMod, L, exec, serpantinum lock" # Lock

        # Quick launch
        "$mod, RETURN, exec, uwsm app -- ${pkgs.ghostty}/bin/ghostty" # Ghostty (terminal)
        "$mod, T, exec, uwsm app -- ${pkgs.kitty}/bin/kitty" # Kitty (terminal)
        "$mod, E, exec,  uwsm app -- ${pkgs.thunar}/bin/thunar" # Thunar
        "$mod, SPACE, exec, serpantinum msg toggle launcher" # Launcher
        "$mod, P, exec, serpantinum msg toggle wallpaper" # Wallpaper picker
        "$mod, N, exec, serpantinum msg toggle system" # Sidebar (Notifications, quick actions)
        "$mod, W, exec, uwsm app -- zen-beta"

        "$mod, D, exec, sh -c 'hyprctl clients -j | grep -q \"\\\"class\\\": \\\"discord\\\"\" || uwsm app -- discord; hyprctl dispatch togglespecialworkspace communication'" # Special workspaces
        "$mod, G, exec, pypr toggle github" # Github
        "CONTROL SHIFT, ESCAPE, exec, pypr toggle sysmon" # Btop
        "$mod, S, exec, pypr toggle music" # Spotify
        "$mod, M, exec, pypr toggle mail" # Proton mail
        "$mod, V, exec, pypr toggle vpn" # Proton mail
        "$mod, O, exec, pypr toggle notes" # Obsidian
        "$mod, C, exec, pypr toggle claude-desktop" # Claude desktop
        "$mod, Tab, exec, ~/.config/nixos/home/desktop/serpantinum/scripts/cycle-toggle.sh" # Bar toggles

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
        # "$shiftMod+Alt, S, exec, serpantinum screenshot" # Capture
        "$shiftMod, S, exec, serpantinum screenshot" # Capture region
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
      ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
      ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"

      # Sound
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioRaiseVolume, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    ];
  };
}
