{pkgs, ...}: let
  pyprlandSettings = {
    pyprland.plugins = ["scratchpads"];
    scratchpads.github = {
      command = "github-desktop";
      class = "github-desktop";
      size = "75% 60%";
      lazy = true;
    };
    scratchpads.sysmon = {
      command = "kitty --class btop -e btop";
      class = "btop";
      size = "75% 75%";
      lazy = true;
    };
    scratchpads.notes = {
      command = "obsidian";
      class = "obsidian";
      size = "75% 75%";
      lazy = true;
    };
    scratchpads.music = {
      command = "spotify";
      class = "spotify";
      size = "70% 60%";
      lazy = true;
    };
    scratchpads.mail = {
      command = "proton-mail";
      class = "proton-mail";
      size = "85% 85%";
      lazy = true;
    };
    scratchpads.vpn = {
      command = "protonvpn-app";
      class = "proton-vpn";
      size = "60% 60%";
      lazy = true;
    };
  };
in {
  home.packages = [pkgs.pyprland];

  xdg.configFile."/home/alexy/.config/pypr/config.toml".source =
    (pkgs.formats.toml {}).generate "pyprland-config" pyprlandSettings;

  wayland.windowManager.hyprland.settings.exec-once = [
    "pypr"
  ];
}
