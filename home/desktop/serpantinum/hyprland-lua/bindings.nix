{
  pkgs,
  lib,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    mod = {_var = "SUPER";};
    shiftMod = {_var = lib.generators.mkLuaInline ''mod .. " + SHIFT"'';};

    bind =
      [
        # Settings / lock
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + X"'')
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("serpantinum msg toggle guide")'')
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline ''shiftMod .. " + L"'')
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("serpantinum lock")'')
          ];
        }

        # Quick launch
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + RETURN"'')
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("uwsm app -- ${pkgs.ghostty}/bin/ghostty")'')
          ];
        } # Ghostty (terminal)
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + T"'')
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("uwsm app -- ${pkgs.kitty}/bin/kitty")'')
          ];
        } # Kitty (terminal)
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + E"'')
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("uwsm app -- ${pkgs.thunar}/bin/thunar")'')
          ];
        } # Thunar
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + SPACE"'')
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("serpantinum msg toggle launcher")'')
          ];
        } # Launcher
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + P"'')
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("serpantinum msg toggle wallpaper")'')
          ];
        } # Wallpaper picker
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + N"'')
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("serpantinum msg toggle system")'')
          ];
        } # Sidebar (notifications, quick actions)
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + W"'')
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("uwsm app -- zen-beta")'')
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + D"'')
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd([[sh -c 'hyprctl clients -j | grep -q "\"class\": \"discord\"" || uwsm app -- discord; hyprctl dispatch togglespecialworkspace communication']])'')
          ];
        } # Special workspaces
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + G"'')
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("pypr toggle github")'')
          ];
        } # Github
        {
          _args = [
            "CONTROL + SHIFT + ESCAPE"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("pypr toggle sysmon")'')
          ];
        } # Btop
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + S"'')
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("pypr toggle music")'')
          ];
        } # Spotify
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + M"'')
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("pypr toggle mail")'')
          ];
        } # Proton mail
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + V"'')
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("pypr toggle vpn")'')
          ];
        } # Proton VPN
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + O"'')
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("pypr toggle notes")'')
          ];
        } # Obsidian

        # Windows
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + Q"'')
            (lib.generators.mkLuaInline ''hl.dsp.window.close()'')
          ];
        } # Close window
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + F"'')
            (lib.generators.mkLuaInline ''hl.dsp.window.fullscreen()'')
          ];
        } # Toggle fullscreen
        {
          _args = [
            (lib.generators.mkLuaInline ''shiftMod .. " + F"'')
            (lib.generators.mkLuaInline ''hl.dsp.window.float({ action = "toggle" })'')
          ];
        } # Toggle floating
        {
          _args = [
            (lib.generators.mkLuaInline ''shiftMod .. " + N"'')
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("nightshift-toggle")'')
          ];
        } # Nightshift

        # Focus windows
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + H"'')
            (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "left" })'')
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + J"'')
            (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "down" })'')
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + K"'')
            (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "up" })'')
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + L"'')
            (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "right" })'')
          ];
        }

        # For multiple monitors / master layout
        {
          _args = [
            (lib.generators.mkLuaInline ''shiftMod .. " + J"'')
            (lib.generators.mkLuaInline ''hl.dsp.layout("removemaster")'')
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline ''shiftMod .. " + K"'')
            (lib.generators.mkLuaInline ''hl.dsp.layout("addmaster")'')
          ];
        }
        # {
        #   _args = [
        #     (lib.generators.mkLuaInline ''shiftMod .. " + H"'')
        #     (lib.generators.mkLuaInline ''hl.dsp.monitor.focus({ relative = -1 })'')
        #   ];
        # } # Focus previous monitor
        # {
        #   _args = [
        #     (lib.generators.mkLuaInline ''shiftMod .. " + L"'')
        #     (lib.generators.mkLuaInline ''hl.dsp.monitor.focus({ relative = 1 })'')
        #   ];
        # } # Focus next monitor

        # Utilities
        {
          _args = [
            (lib.generators.mkLuaInline ''shiftMod .. " + S"'')
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("serpantinum screenshot")'')
          ];
        } # Capture region

        # For floating windows (mouse binds)
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + mouse:272"'')
            (lib.generators.mkLuaInline ''hl.dsp.window.drag()'')
            {mouse = true;}
          ];
        } # Move window (mouse)
        {
          _args = [
            (lib.generators.mkLuaInline ''mod .. " + R"'')
            (lib.generators.mkLuaInline ''hl.dsp.window.resize()'')
            {mouse = true;}
          ];
        } # Resize window (mouse)

        # Keyboard functions (locked binds — work even when the screen is locked)
        {
          _args = [
            "XF86MonBrightnessUp"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("brightnessctl set 5%+")'')
            {locked = true;}
          ];
        }
        {
          _args = [
            "XF86MonBrightnessDown"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("brightnessctl set 5%-")'')
            {locked = true;}
          ];
        }
        {
          _args = [
            "XF86AudioMute"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")'')
            {locked = true;}
          ];
        }
        {
          _args = [
            "XF86AudioRaiseVolume"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+")'')
            {locked = true;}
          ];
        }
        {
          _args = [
            "XF86AudioLowerVolume"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")'')
            {locked = true;}
          ];
        }
      ]
      # Switch / move workspaces
      ++ (builtins.concatLists (
        builtins.genList (
          i: let
            ws = i + 1;
          in [
            {
              _args = [
                (lib.generators.mkLuaInline ''mod .. " + code:1${toString i}"'')
                (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = ${toString ws} })'')
              ];
            }
            {
              _args = [
                (lib.generators.mkLuaInline ''shiftMod .. " + code:1${toString i}"'')
                (lib.generators.mkLuaInline ''hl.dsp.window.move({ workspace = ${toString ws} })'')
              ];
            }
          ]
        )
        9
      ));
  };
}
