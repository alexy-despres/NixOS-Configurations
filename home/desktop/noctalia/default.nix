{inputs, ...}: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  wayland.windowManager.hyprland.settings.exec-once = ["noctalia"];

  programs.noctalia = {
    enable = true;
    settings = builtins.fromTOML (builtins.readFile ./noctalia-config.toml);
  };
}
