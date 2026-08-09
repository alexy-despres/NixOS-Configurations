{pkgs, ...}: let
  localDir = "/home/alexy/ProtonDrive"; # adjust to your local sync folder
  remoteName = "protondrive"; # must match your `rclone config` remote name
in {
  environment.systemPackages = [pkgs.rclone];

  systemd.user.services.proton-drive-bisync = {
    description = "Proton Drive bisync";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''
        ${pkgs.rclone}/bin/rclone bisync ${localDir} ${remoteName}: \
          --max-delete 10 \
          --conflict-resolve newer \
          --conflict-loser num \
          --check-access \
          --resilient
      '';
    };
  };

  systemd.user.timers.proton-drive-bisync = {
    description = "Run Proton Drive bisync every 30 minutes";
    wantedBy = ["timers.target"];
    timerConfig = {
      OnBootSec = "2min";
      OnUnitActiveSec = "30min";
    };
  };
}
