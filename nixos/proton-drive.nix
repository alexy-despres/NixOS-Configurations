{pkgs, ...}: {
  environment.systemPackages = [pkgs.rclone pkgs.fuse3];

  systemd.user.services.rclone-protondrive-mount = {
    description = "Rclone ProtonDrive mount";
    after = ["network-online.target"];
    wants = ["network-online.target"];
    wantedBy = ["default.target"];
    serviceConfig = {
      Type = "notify";
      Environment = "PATH=/run/wrappers/bin:/run/current-system/sw/bin";
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p %h/Drives/ProtonDrive";
      ExecStart = ''
        ${pkgs.rclone}/bin/rclone mount protondrive: %h/Drives/ProtonDrive \
          --vfs-cache-mode writes \
          --vfs-cache-max-age 24h \
          --dir-cache-time 30s \
          --poll-interval 15s \
          --allow-other=false
      '';
      ExecStop = "${pkgs.fuse3}/bin/fusermount3 -u %h/Drives/ProtonDrive";
      Restart = "on-failure";
      RestartSec = 10;
    };
  };
}
