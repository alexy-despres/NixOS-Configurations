{
  description = ''
    My personal configurations for NixOS (Nixy fork)
  '';

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    stylix.url = "github:danth/stylix";
    nvf.url = "github:notashelf/nvf";
    notashelf-tuigreet.url = "github:NotAShelf/tuigreet";
    nur-anotherhadi.url = "github:anotherhadi/nur-packages";

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
    ...
  }: let
    system = "x86_64-linux";

    pkgs = nixpkgs.legacyPackages.${system};
    pkgs-stable = nixpkgs-stable.legacyPackages.${system};
    pkgs-nur-hadi = inputs.nur-anotherhadi.packages.${system};

    args = {
      inherit
        inputs
        nixpkgs
        system
        pkgs
        pkgs-stable
        pkgs-nur-hadi
        ;
    };

    merge = nixpkgs.lib.foldl nixpkgs.lib.recursiveUpdate {};
  in
    merge [
      (import ./home/programs/nvf/flake.nix args)
      (import ./home/programs/group/flake.nix args)

      {
        formatter.${system} = pkgs.alejandra;
        nixosConfigurations = {
          laptop = import ./hosts/laptop/flake.nix args; # My laptop
        };
      }
    ];
}
