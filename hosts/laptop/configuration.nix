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
    ../../nixos/systemd-boot.nix
    ../../nixos/tuigreet.nix
    ../../nixos/usbguard.nix
    ../../nixos/users.nix
    ../../nixos/utils.nix

    ./hardware-configuration.nix
    ./variables.nix
  ];

  # USBGuard:
  # Allow all USB devices until a proper policy is configured.
  # Run `sudo usbguard generate-policy` with your devices plugged in,
  # then set rules = "<output>" and switch implicitPolicyTarget to "block".
  # services.usbguard.implicitPolicyTarget = lib.mkForce "allow";

  services.usbguard.rules = ''
    allow *
    # TODO
  '';

  home-manager.users."${config.var.username}" = import ./home.nix;

  system.stateVersion = "24.05";
}
