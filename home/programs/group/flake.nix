{
  inputs,
  pkgs,
  pkgs-stable,
  pkgs-nur-hadi,
  system,
  ...
}: let
  devPackages = import ./dev-packages.nix {inherit pkgs pkgs-stable;};
in {
  packages.${system} = {
    dev = pkgs.buildEnv {
      name = "dev-tools";
      paths = devPackages;
    };
  };
}
