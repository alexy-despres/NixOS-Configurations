{lib, ...}: {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        ignore_empty_input = true;
        disable_loading_bar = true;
        no_fade_in = false;
      };

      animations = {
        enabled = true;
        fade_in = {
          duration = 300;
          bezier = "easeOutQuint";
        };
        fade_out = {
          duration = 300;
          bezier = "easeOutQuint";
        };
      };

      background = lib.mkForce [
        {
          path = "screenshot";
          blur_passes = 4;
          blur_size = 7;
          brightness = 0.5;
          vibrancy = 0.1;
          vibrancy_darkness = 0.5;
        }
      ];

      label = [
        # Hours
        {
          monitor = "";
          text = "cmd[update:1000] date +\"%H\"";
          color = "rgba(ffb878ff)";
          font_size = 96;
          font_family = "JetBrains Mono Bold";
          position = "-90, 160";
          halign = "center";
          valign = "center";
        }
        # colon
        {
          monitor = "";
          text = ":";
          color = "rgba(8e9159ff)";
          font_size = 96;
          font_family = "JetBrains Mono Bold";
          position = "0, 160";
          halign = "center";
          valign = "center";
        }
        # minutes
        {
          monitor = "";
          text = "cmd[update:1000] date +\"%M\"";
          color = "rgba(e5bfa1ff)";
          font_size = 96;
          font_family = "JetBrains Mono Bold";
          position = "90, 160";
          halign = "center";
          valign = "center";
        }

        # Date
        {
          monitor = "";
          text = "cmd[update:60000] LC_ALL=C date +\"%A, %B %d\"";
          color = "rgba(b98558ff)";
          font_size = 18;
          font_family = "JetBrains Mono Bold";
          position = "0, 80";
          halign = "center";
          valign = "center";
        }

        # KB layout
        {
          monitor = "";
          text = "cmd[update:500] hyprctl devices -j | jq -r '.keyboards[] | select(.main==true) | .active_keymap' | head -n1 | cut -c1-2 | tr '[:lower:]' '[:upper:]'";
          color = "rgba(e5bfa1ff)";
          font_size = 13;
          font_family = "JetBrains Mono Bold";
          position = "-25, -25";
          halign = "center";
          valign = "center";
        }

        # Battery
        {
          monitor = "";
          text = "cmd[update:5000] cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -n1 | tr -d '\\n' | xargs -I{} echo '{}%' || echo 'AC'";
          color = "rgba(8e9159ff)";
          font_size = 13;
          font_family = "JetBrains Mono Bold";
          position = "25, -25";
          halign = "center";
          valign = "center";
        }
      ];

      input-field = lib.mkForce [
        {
          monitor = "";
          size = "280, 55";
          position = "0, 20";
          halign = "center";
          valign = "center";

          outline_thickness = 2;
          dots_size = 0.28;
          dots_spacing = 0.25;
          dots_center = true;
          dots_rounding = -1;
          rounding = 27; # pill shape — half of height

          outer_color = "rgb(2b231d)";
          inner_color = "rgb(130e0b)";
          font_color = "rgb(ece0d9)";

          fade_on_empty = false;
          placeholder_text = ''<span foreground="##3a322b">Password...</span>'';

          check_color = "rgb(ffb878ff)";
          fail_color = "rgb(8e0d0d)";
          fail_text = ''<i>wrong · $ATTEMPTS attempt(s)</i>'';

          shadow_passes = 2;
          shadow_size = 4;
          shadow_color = "rgb(000000)";
          shadow_boost = 1.2;
        }
      ];
    };
  };
}
