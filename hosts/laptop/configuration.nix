{config, ...}: {
  imports = [
    # Basic system modules
    ../../nixos/audio.nix
    ../../nixos/bluetooth.nix
    ../../nixos/fonts.nix
    ../../nixos/home-manager.nix
    ../../nixos/hyprland.nix
    ../../nixos/intel-graphics.nix
    ../../nixos/nix.nix
    ../../nixos/nvidia.nix
    ../../nixos/boot.nix
    ../../nixos/tuigreet.nix
    ../../nixos/users.nix
    ../../nixos/utils.nix
    ../../nixos/virtualization.nix

    ./hardware-configuration.nix
    ./variables.nix
  ];

  home-manager.users."${config.var.username}" = import config.var.userConfigs;

  system.stateVersion = "24.05";
}
