{
  lib,
  pkgs,
  ...
}: let
  themeSync = pkgs.writeShellApplication {
    name = "theme-sync";
    runtimeInputs = [pkgs.jq];
    text = ''
      set -euo pipefail
      COLORS_JSON="$HOME/.local/state/serpantinum/qs_matugen_colors.json"
      HYPR_OUT="$HOME/.config/hypr/colors.conf"
      GHOSTTY_OUT="$HOME/.config/ghostty/config-colors"
      mkdir -p "$(dirname "$HYPR_OUT")" "$(dirname "$GHOSTTY_OUT")"

      get() { jq -r --arg k "$1" '.[$k]' "$COLORS_JSON" | sed 's/#//'; }

      jq -r 'to_entries[] | "$\(.key) = rgb(\(.value | ltrimstr("#")))"' "$COLORS_JSON" > "$HYPR_OUT"

      {
        echo "background = $(get base)"
        echo "foreground = $(get text)"
        echo "cursor-color = $(get text)"
        echo "selection-background = $(get surface1)"
        echo "selection-foreground = $(get text)"
        echo "palette = 0=#$(get crust)"
        echo "palette = 1=#$(get red)"
        echo "palette = 2=#$(get green)"
        echo "palette = 3=#$(get yellow)"
        echo "palette = 4=#$(get blue)"
        echo "palette = 5=#$(get mauve)"
        echo "palette = 6=#$(get teal)"
        echo "palette = 7=#$(get subtext1)"
        echo "palette = 8=#$(get surface2)"
        echo "palette = 9=#$(get red)"
        echo "palette = 10=#$(get green)"
        echo "palette = 11=#$(get yellow)"
        echo "palette = 12=#$(get sapphire)"
        echo "palette = 13=#$(get pink)"
        echo "palette = 14=#$(get teal)"
        echo "palette = 15=#$(get text)"
      } > "$GHOSTTY_OUT"

      hyprctl reload >/dev/null 2>&1 || true
      systemctl reload --user app-com.mitchellh.ghostty.service 2>/dev/null \
        || pkill -SIGUSR2 ghostty 2>/dev/null || true
    '';
  };
in {
  home.activation.themeSync = lib.hm.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD ${themeSync}/bin/theme-sync || true
  '';

  systemd.user.services.theme-sync = {
    Unit.Description = "Regenerate Hyprland/Ghostty colors from matugen JSON";
    Service = {
      Type = "oneshot";
      ExecStart = "${themeSync}/bin/theme-sync";
    };
  };

  systemd.user.paths.theme-sync = {
    Unit.Description = "Watch matugen colors.json";
    Path.PathModified = "%h/.local/state/serpantinum/qs_matugen_colors.json";
    Install.WantedBy = ["default.target"];
  };
}
