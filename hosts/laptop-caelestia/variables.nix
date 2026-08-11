{
  config,
  lib,
  ...
}: {
  imports = [
    ../../themes/gruvbox.nix # Theme chosen
  ];

  config.var = {
    hostname = "laptop-caelestia";
    username = "alexy";
    userConfigs = ./users/alexy.nix;
    homeDirectory = "/home/" + config.var.username;
    configDirectory = "/home/" + config.var.username + "/.config/nixos"; # Do not change this

    keyboardLayout = "us";

    timeZone = "America/Montreal";
    defaultLocale = "en_US.UTF-8";
    extraLocale = "fr_CA.UTF-8";

    git = {
      username = "alexy-despres";
      email = "alexydespres.dev@gmail.com";
    };

    autoUpgrade = false;
    autoGarbageCollector = true;
  };

  options = {
    var = lib.mkOption {
      type = lib.types.attrs;
      default = {};
    };
  };
}
