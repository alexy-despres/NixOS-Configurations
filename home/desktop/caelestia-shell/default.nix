# Caelestia Shell Home Manager Configuration
# See https://github.com/caelestia-dots/shell
{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.caelestia-shell.homeManagerModules.default
    ./bar.nix
    ./launcher.nix
    ./appearance.nix
    ./background.nix
    ./swappy.nix
  ];

  programs.caelestia = {
    enable = true;
    systemd.enable = false;
    settings = {
      services.weatherLocation = "Sherbrooke";
      general = {
        apps = {
          terminal = ["ghostty"];
          audio = ["pavucontrol"];
          explorer = ["thunar"];
        };
        idle = {
          timeouts = [];
        };
      };
    };
    cli = {
      enable = true;
      settings.theme = {
        enableTerm = false;
        enableDiscord = true;
        enableSpicetify = false;
        enableBtop = false;
        enableCava = false;
        enableHypr = false;
        enableGtk = false;
        enableQt = false;
      };
      settings.toggles = {
        communication = {
          discord = {
            enable = true;
            match = [
              {class = "discord";}
            ];
            command = ["discord"];
            move = true;
          };
          whatsapp = {
            enable = false;
          };
          signal = {
            enable = false;
          };
        };
        sysmon.btop = {
          enable = true;
          match = [
            {
              class = "btop";
              title = "btop";
              workspace = {
                name = "special:sysmon";
              };
            }
          ];
          command = ["ghostty" "-e" "btop"];
        };
        music = {
          spotify = {
            enable = true;
            match = [
              {class = "spotify";}
              {initialTitle = "Spotify";}
            ];
            command = ["spotify"];
            move = true;
          };
        };
      };
    };
  };

  home.packages = with pkgs; [
    gpu-screen-recorder
  ];

  wayland.windowManager.hyprland.settings.exec-once = [
    "uwsm app -- caelestia resizer -d"
    "uwsm app -- caelestia shell -d"
    "caelestia scheme set -n gruvbox -f soft -v tonalspot"
  ];

  # shell.json is managed by home-manager (read-only symlink) but caelestia
  # needs to write to it at runtime: replace the symlink with a mutable copy.
  # The stale .hm-backup must be removed before linkGeneration so HM can
  # back up the runtime-modified shell.json without hitting a conflict.
  home.activation.caelestiaCleanBackup = lib.hm.dag.entryBefore ["linkGeneration"] ''
    $DRY_RUN_CMD rm -f "$HOME/.config/caelestia/shell.json.hm-backup"
  '';

  home.activation.caelestiaWritableShellConfig = lib.hm.dag.entryAfter ["linkGeneration"] ''
    if [ -L "$HOME/.config/caelestia/shell.json" ]; then
      $DRY_RUN_CMD cp --remove-destination \
        "$(readlink -f "$HOME/.config/caelestia/shell.json")" \
        "$HOME/.config/caelestia/shell.json"
    fi
  '';

  services.cliphist = {
    enable = true;
    allowImages = true;
  };
}
