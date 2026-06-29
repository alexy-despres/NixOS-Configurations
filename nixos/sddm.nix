{
  services.displayManager.sddm = {
    enable = true;

    wayland = {
      enable = true;

      # default compositor is "weston", you can optionally change it to kwin
      #compositor = "kwin";
    };
    defaultSession = "hyprland";
  };
}
