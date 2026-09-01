{
  pkgs,
  config,
  ...
}: let
  pyprlandSettings = {
    pyprland.plugins = ["scratchpads"];
    scratchpads = {
      github = {
        command = "github-desktop";
        class = "github-desktop";
        size = "75% 60%";
        lazy = true;
      };
      sysmon = {
        command = "kitty --class btop -e btop";
        class = "btop";
        size = "75% 75%";
        lazy = true;
      };
      notes = {
        command = "obsidian";
        class = "obsidian";
        size = "75% 75%";
        lazy = true;
      };
      music = {
        command = "spotify";
        class = "spotify";
        size = "70% 60%";
        lazy = true;
      };
      mail = {
        command = "proton-mail";
        class = "proton-mail";
        size = "85% 85%";
        lazy = true;
      };
      vpn = {
        command = "protonvpn-app";
        class = "proton-vpn";
        size = "60% 60%";
        lazy = true;
      };
    };
  };
in {
  home.packages = [pkgs.pyprland];
  xdg.configFile."${config.var.homeDirectory}/.config/pypr/config.toml".source =
    (pkgs.formats.toml {}).generate "pyprland-config" pyprlandSettings;
}
