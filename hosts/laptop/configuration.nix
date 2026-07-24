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
    ../../nixos/docker.nix
    ../../nixos/tuigreet.nix
    # ../../nixos/sddm.nix # FUCK SDDM BRO IT WON'T WORK
    ../../nixos/users.nix
    ../../nixos/utils.nix
    ../../nixos/virtualization.nix
    ../../nixos/firejail.nix

    ./hardware-configuration.nix
    ./variables.nix
  ];

  home-manager.users."${config.var.username}" = import config.var.userConfigs;

  system.stateVersion = "24.05";
}
