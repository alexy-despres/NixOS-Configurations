{
  description = ''
    My personal configurations for NixOS (Nixy fork)
  '';

  inputs = {
    nixpkgs-bleeding.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    stylix.url = "github:danth/stylix";
    nvf.url = "github:notashelf/nvf";
    notashelf-tuigreet.url = "github:NotAShelf/tuigreet";

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    caelestia-cli = {
      url = "github:caelestia-dots/cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
  };

  outputs = inputs @ {
    nixpkgs,
    nixpkgs-stable,
    nixpkgs-bleeding,
    ...
  }: let
    system = "x86_64-linux";

    pkgs = nixpkgs.legacyPackages.${system};
    pkgs-stable = nixpkgs-stable.legacyPackages.${system};
    pkgs-bleeding = nixpkgs-bleeding.legacyPackages.${system};

    args = {
      inherit
        inputs
        nixpkgs
        system
        pkgs
        pkgs-stable
        pkgs-bleeding
        ;
    };
  in {
    formatter.${system} = pkgs.alejandra; # Auto formatting
    nixosConfigurations = {
      # Import all hosts
      laptop = import ./hosts/laptop/flake.nix args;
      laptop-noctalia = import ./hosts/laptop-noctalia/flake.nix args;
    };
  };
}
