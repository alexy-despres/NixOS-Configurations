{
  pkgs,
  pkgs-stable,
  inputs,
  ...
}: {
  home.packages = with pkgs-stable; [
    nodejs
    air
    duckdb
    python3
    jq
    nix-prefetch-github
    rsync
    home-manager
    vscodium
    pkgs.claude-code
    inputs.claude-desktop.packages.${stdenv.hostPlatform.system}.claude-desktop
  ];
}
