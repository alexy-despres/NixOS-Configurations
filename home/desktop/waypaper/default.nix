# Wallpaper picker (Not fixed)
{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    waypaper
    inputs.gslapper.packages.${pkgs.system}.gslapper
    awww # Need to kill gslapper manually if switching to awww
  ];

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "awww-daemon"
      "waypaper --restore"
      "systemctl --user unset-environment GDK_PIXBUF_MODULE_FILE"
    ];
  };
}
