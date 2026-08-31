{pkgs, ...}: {
  programs.niri.settings.spawn-at-startup = [
    {command = ["waybar"];}
  ];
  programs.waybar = {
    enable = true;
    systemd.enable = true; # let systemd start/restart it with your session

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 34;
        spacing = 4;

        modules-left = ["niri/workspaces" "niri/window"];
        modules-center = ["clock"];
        modules-right = ["pulseaudio" "network" "cpu" "memory" "battery" "tray"];

        "niri/workspaces" = {
          format = "{icon}";
          format-icons = {
            active = "";
            default = "";
          };
        };

        "niri/window" = {
          format = "{title}";
          max-length = 50;
        };

        clock = {
          format = "{:%a %d %b  %H:%M}";
          tooltip-format = "{:%Y-%m-%d}";
        };

        cpu = {
          format = " {usage}%";
          interval = 5;
        };

        memory = {
          format = " {}%";
          interval = 5;
        };

        battery = {
          format = "{icon} {capacity}%";
          format-icons = ["" "" "" "" ""];
          format-charging = " {capacity}%";
          states = {
            warning = 30;
            critical = 15;
          };
        };

        network = {
          format-wifi = " {essid} ({signalStrength}%)";
          format-ethernet = " {ifname}";
          format-disconnected = "⚠ disconnected";
          tooltip-format = "{ipaddr}/{cidr}";
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = " muted";
          format-icons = {
            default = ["" "" ""];
          };
          on-click = "pavucontrol";
        };

        tray = {
          spacing = 8;
        };
      };
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font", sans-serif;
        font-size: 13px;
      }

      window#waybar {
        background-color: rgba(30, 30, 46, 0.85);
        color: #cdd6f4;
      }

      #workspaces button {
        padding: 0 6px;
        color: #cdd6f4;
      }

      #workspaces button.active {
        color: #89b4fa;
      }

      #clock,
      #cpu,
      #memory,
      #battery,
      #network,
      #pulseaudio,
      #tray {
        padding: 0 10px;
      }

      #battery.warning {
        color: #f9e2af;
      }

      #battery.critical {
        color: #f38ba8;
      }
    '';
  };
}
