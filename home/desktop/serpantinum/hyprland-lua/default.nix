{
  pkgs,
  config,
  lib,
  ...
}: let
  # border-size = config.theme.border-size;
  # gaps-in = config.theme.gaps-in;
  # gaps-out = config.theme.gaps-out;
  # active-opacity = config.theme.active-opacity;
  # inactive-opacity = config.theme.inactive-opacity;
  # rounding = config.theme.rounding;
  blur = config.theme.blur;
  keyboardLayout = config.var.keyboardLayout;
in {
  imports = [
    ./animations.nix
    ./polkitagent.nix
    ./bindings.nix
    ./pyprland.nix
  ];

  home.packages = with pkgs; [
    qt5.qtwayland
    qt6.qtwayland
    libsForQt5.qt5ct
    qt6Packages.qt6ct
    xcb-util-cursor
    libxcb
    hyprland-qtutils
    adw-gtk3
    hyprshot
    hyprpicker
    swappy
    imv
    wf-recorder
    wlr-randr
    brightnessctl
    gnome-themes-extra
    dconf
    wayland-utils
    wayland-protocols
    pulseaudio
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    xwayland.enable = true;

    systemd = {
      enable = false;
      variables = [
        "--all"
      ]; # https://wiki.hyprland.org/Nix/Hyprland-on-Home-Manager/#programs-dont-work-in-systemd-services-but-do-on-the-terminal
    };

    package = null;
    portalPackage = null;

    settings = {
      monitor = lib.mkForce [
        {
          _args = [
            {
              output = "";
              mode = "prefered";
              position = "auto";
              scale = 1;
            }
          ];
        }
      ];

      # exec-once
      on = {
        _args = [
          "hyprland.start"
          (lib.generators.mkLuaInline ''
            function()
              hl.exec_cmd("dbus-update-activation-environment --systemd --all &")
              hl.exec_cmd("kdeconnectd")
              hl.exec_cmd("serpantinumd start")
              hl.exec_cmd("systemctl --user start hyprpolkitagent")
              hl.exec_cmd("pypr")
            end
          '')
        ];
      };

      env = [
        {_args = ["XDG_CURRENT_DESKTOP" "Hyprland"];}
        {_args = ["XDG_SESSION_TYPE" "wayland"];}
        {_args = ["XDG_SESSION_DESKTOP" "Hyprland"];}
        {_args = ["ANKI_WAYLAND" "1"];}
        {_args = ["DISABLE_QT5_COMPAT" "0"];}
        {_args = ["QT_AUTO_SCREEN_SCALE_FACTOR" "1"];}
        {_args = ["QT_QPA_PLATFORM" "wayland;xcb"];}
        {_args = ["QT_QPA_PLATFORMTHEME" "gtk3"];}
        {_args = ["QT_WAYLAND_DISABLE_WINDOWDECORATION" "1"];}
        {_args = ["ELECTRON_OZONE_PLATFORM_HINT" "auto"];}
        {_args = ["DIRENV_LOG_FORMAT" ""];}
        {_args = ["SDL_VIDEODRIVER" "wayland"];}
        {_args = ["CLUTTER_BACKEND" "wayland"];}
      ];

      config = {
        cursor = {
          no_hardware_cursors = true;
          default_monitor = "eDP-1";
        };

        general = {
          resize_on_border = true;
          # gaps_in = gaps-in;
          # gaps_out = gaps-out;
          # border_size = border-size;
          layout = "master";
          # col = {
          #   active_border = "rgb(2a2a2a)";
          #   inactive_border = "rgb(1a1a1a)";
          # };
        };

        decoration = {
          # active_opacity = active-opacity;
          # inactive_opacity = inactive-opacity;
          # rounding = rounding;
          shadow = {
            enabled = true;
            range = 20;
            render_power = 3;
          };
          blur = {
            enabled = blur;
            size = 18;
          };
        };

        master = {
          new_status = "slave";
          allow_small_split = true;
          mfact = 0.5;
        };

        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          disable_autoreload = false;
          focus_on_activate = true;
        };

        input = {
          kb_layout = keyboardLayout;
          kb_options = "caps:escape";
          follow_mouse = 1;
          sensitivity = 0.5;
          repeat_delay = 300;
          repeat_rate = 50;
          numlock_by_default = true;

          touchpad = {
            natural_scroll = true;
            tap_button_map = "lrm"; # Left, Right, Middle mapping
            tap_to_click = true; # Enable tapping
            disable_while_typing = true; # Prevent accidental touches while typing
          };
        };

        ecosystem = {
          no_update_news = true;
        };
      };

      gesture = {
        fingers = 3;
        direction = "horizontal";
        action = "workspace";
      };

      window_rule = [
        {
          match.class = ".*";
          suppress_event = "maximize";
        }
        {
          match.title = "run-bg";
          float = true;
          center = true;
          size = [700 80];
        }
        {
          # Special workspaces
          match.class = "discord";
          workspace = "special:communication";
        }
      ];
    };
  };
}
