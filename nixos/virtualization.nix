{config, ...}: {
  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;

    libvirtd.qemu = {
      swtpm.enable = true; # TPM support
    };
  };

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["${config.var.username}"];
}
