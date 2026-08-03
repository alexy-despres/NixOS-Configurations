{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default
    ./hyprland
    ./stylix.nix
  ];

  wayland.windowManager.hyprland.settings.exec-once = ["noctalia"];

  programs.noctalia = {
    enable = true;
    settings = builtins.fromTOML (builtins.readFile ./noctalia-config.toml);
  };

  home.packages = with pkgs; [
    inputs.gslapper.packages.${pkgs.system}.gslapper
    gst_all_1.gstreamer
    # gst_all_1.gst-plugins-base
    # gst_all_1.gst-plugins-good
    # gst_all_1.gst-plugins-bad
    # gst_all_1.gst-plugins-ugly
    socat
  ];
}
