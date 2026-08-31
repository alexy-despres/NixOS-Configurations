{config, ...}: {
  imports = [
    # Programs
    ../../../home/programs/ghostty # Terminal
    ../../../home/programs/kitty # Other terminal
    #
    ../../../home/programs/group/basic-apps.nix # Basic stuff
    ../../../home/programs/group/dev.nix # Dev stuff
    #
    ../../../home/programs/git
    ../../../home/programs/git/lazygit.nix
    #
    # ../../../home/programs/nightshift # AKA night light
    ../../../home/programs/nix-utils # Nix-index-db
    ../../../home/programs/nvf # Nvim
    ../../../home/programs/qemu # Qemu
    ../../../home/programs/shell # Shell stuff
    #
    ../../../home/programs/thunar # File explorer
    ../../../home/programs/yazi # Terminal file explorer
    ../../../home/programs/zen-browser # Browser
    #
    # # Desktop environment
    ../../../home/desktop/mime
    ../../../home/desktop/udiskie # Auto mount drives
    ../../../home/desktop/niri
    ../../../home/desktop/waybar
    #
    ../variables.nix
  ];

  home = {
    inherit (config.var) username homeDirectory;

    file.".face" = {
      source = ../profile-picture.jpg;
    };

    # sessionVariables = {
    #   AQ_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0";
    # };

    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}
