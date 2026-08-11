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
    ./hyprland
    ./stylix.nix
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
        enableTerm = true;
        enableDiscord = true;
        enableSpicetify = false;
        enableBtop = true;
        enableCava = false;
        enableHypr = true;
        enableGtk = true;
        enableQt = true;
      };
      settings.toggles = {
        communication = {
          discord = {
            enable = true;
            match = [{class = "discord";}];
            command = ["discord"];
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
    "dbus-update-activation-environment --systemd HYPRLAND_INSTANCE_SIGNATURE WAYLAND_DISPLAY XDG_RUNTIME_DIR"
    "systemctl --user import-environment HYPRLAND_INSTANCE_SIGNATURE WAYLAND_DISPLAY XDG_RUNTIME_DIR"
    "uwsm app -- caelestia resizer -d"
    "uwsm app -- caelestia shell -d"

    "${pkgs.writeShellScript "caelestia-border-sync" ''
      SCHEME_DIR="$HOME/.local/state/caelestia"
      SCHEME_FILE="$SCHEME_DIR/scheme.json"

      update_borders() {
        if [ -f "$SCHEME_FILE" ]; then
          primary=$(${pkgs.jq}/bin/jq -r '.colours.primary // empty' "$SCHEME_FILE" | tr -d '#')
          inactive=$(${pkgs.jq}/bin/jq -r '.colours.outlineVariant // .colours.surfaceVariant // .colours.surface // empty' "$SCHEME_FILE" | tr -d '#')

          if [ -n "$primary" ]; then
            hyprctl keyword general:col.active_border "rgba(''${primary}ff)"
          fi
          if [ -n "$inactive" ]; then
            hyprctl keyword general:col.inactive_border "rgba(''${inactive}ff)"
          fi
        fi
      }

      # Initial sync on boot
      update_borders

      # Watch scheme.json for modifications from GUI or CLI
      ${pkgs.inotify-tools}/bin/inotifywait -m -e close_write,moved_to "$SCHEME_DIR" 2>/dev/null | while read -r dir action file; do
        if [ "$file" = "scheme.json" ]; then
          update_borders
        fi
      done
    ''}"
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
        $DRY_RUN_CMD chmod +w "$HOME/.config/caelestia/shell.json"
    fi
  '';

  services.cliphist = {
    enable = true;
    allowImages = true;
  };
}
