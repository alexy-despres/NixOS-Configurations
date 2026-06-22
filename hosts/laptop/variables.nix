{
  config,
  lib,
  ...
}: {
  imports = [
    ../../themes/nixy.nix # Theme chosen
  ];

  config.var = {
    hostname = "laptop";
    username = "alexy";
    configDirectory = "/home/" + config.var.username + "/.config/nixos";

    keyboardLayout = "us";

    timeZone = "America/Montreal";
    defaultLocale = "en_US.UTF-8";
    extraLocale = "fr_CA.UTF-8";

    git = {
      username = "AlexyDespres";
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
