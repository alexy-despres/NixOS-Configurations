# Hyprland is a dynamic tiling Wayland compositor that is highly customizable and performant.
{
  pkgs,
  config,
  lib,
  ...
}: let
  border-size = config.theme.border-size;
  gaps-in = config.theme.gaps-in;
  gaps-out = config.theme.gaps-out;
  active-opacity = config.theme.active-opacity;
  inactive-opacity = config.theme.inactive-opacity;
  rounding = config.theme.rounding;
  blur = config.theme.blur;
  keyboardLayout = config.var.keyboardLayout;
  # background = "rgba(" + config.lib.stylix.colors.base00 + "EE)";
in {
  imports = [
    ./animations.nix
    ./bindings.nix
    ./polkitagent.nix
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
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "hyprlang";
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
      exec-once = [
        "dbus-update-activation-environment --systemd --all &"
      ];

      monitor = [
        ",prefered,auto,1" # default
      ];

      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "ANKI_WAYLAND,1"
        "DISABLE_QT5_COMPAT,0"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_QPA_PLATFORMTHEME,gtk3"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "DIRENV_LOG_FORMAT,"
        "SDL_VIDEODRIVER,wayland"
        "CLUTTER_BACKEND,wayland"
      ];

      cursor = {
        no_hardware_cursors = true;
        default_monitor = "eDP-1";
      };

      general = {
        resize_on_border = true;
        gaps_in = gaps-in;
        gaps_out = gaps-out;
        border_size = border-size;
        layout = "master";
        # "col.inactive_border" = lib.mkForce background;
        "col.active_border" = lib.mkForce "rgba(b88558ff) rgba(ffb878ff) 45deg"; # Gold gradient
        # "col.inactive_border" = lib.mkForce "rgba(665538ff) (b89a4aff) 45deg"; # Muted gold gradient
        "col.inactive_border" = lib.mkForce "rgba(2a1500ff) rgba(3d2000ff) 45deg";
      };

      decoration = {
        active_opacity = active-opacity;
        inactive_opacity = inactive-opacity;
        rounding = rounding;
        shadow = {
          enabled = true;
          range = 20;
          render_power = 3;
        };
        blur = {
          enabled =
            if blur
            then "true"
            else "false";
          size = 18;
        };
      };

      master = {
        new_status = "slave";
        allow_small_split = true;
        mfact = 0.5;
      };

      gesture = "3, horizontal, workspace";

      windowrule = [
        "match:class .*, suppress_event maximize"

        "match:title run-bg, float on"
        "match:title run-bg, center on"
        "match:title run-bg, size 700 80"

        # Special workspaces
        "workspace special:communication, match:class discord"
        "workspace special:sysmon, match:class btop"
        "workspace special:music, match:class spotify"
        "workspace special:github, match:class github"
        "workspace special:obsidian, match:class notes"
      ];

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        disable_autoreload = true;
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
          tap-to-click = true; # Enable tapping
          disable_while_typing = true; # Prevent accidental touches while typing
        };
        # touchpad = {
        #   natural_scroll = true;
        #   clickfinger_behavior = true;
        # };
      };

      ecosystem = {
        no_update_news = true;
      };
    };
  };
}
