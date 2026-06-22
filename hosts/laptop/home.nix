{config, ...}: {
  imports = [
    # Programs
    ../../home/programs/ghostty
    ../../home/programs/nvf
    ../../home/programs/shell
    ../../home/programs/git
    ../../home/programs/git/lazygit.nix
    ../../home/programs/thunar
    ../../home/programs/nixy
    ../../home/programs/nightshift
    ../../home/programs/nix-utils
    ../../home/programs/spotatui
    ../../home/programs/yazi

    ../../home/programs/group/basic-apps.nix
    ../../home/programs/group/dev.nix

    # Desktop environment
    ../../home/system/hyprland
    ../../home/system/caelestia-shell
    ../../home/system/hyprpaper
    ../../home/system/mime
    ../../home/system/udiskie

    ./variables.nix
  ];

  home = {
    inherit (config.var) username;
    homeDirectory = "/home/" + config.var.username;
    file.".face" = {
      source = ./profile_picture.png;
    };

    sessionVariables = {
      AQ_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0";
    };

    stateVersion = "24.05";
  };

  wayland.windowManager.hyprland.settings.monitor = [
    "eDP-1,2560x1600@165,0x0,1" # Internal laptop screen
  ];

  programs = {
    home-manager.enable = true;
    nixy = {
      enable = true;
      configDirectory = config.var.configDirectory;
    };
  };
}
