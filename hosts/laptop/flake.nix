{
  inputs,
  nixpkgs,
  ...
}:
nixpkgs.lib.nixosSystem {
  modules = [
    {
      nixpkgs.overlays = [
      ];
      _module.args = {inherit inputs;};
    }
    inputs.nixos-hardware.nixosModules.asus-zephyrus-gu603h
    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix
    inputs.nix-index-database.nixosModules.default
    inputs.helium-browser.nixosModules.default
    ./configuration.nix
  ];
}
