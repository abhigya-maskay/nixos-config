{
  description = "nixos configuration";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    doomemacs = {
      url = "github:doomemacs/doomemacs";
      flake = false;
    };
    doom-config = {
      url = "github:abhigya-maskay/doom_config";
      flake = false;
    };
    catppuccin = {
      url = "github:catppuccin/nix";
    };
    catppuccin-wallpapers = {
      url = "github:orangci/walls-catppuccin-mocha";
      flake = false;
    };
    nix-ai-tools.url = "github:numtide/nix-ai-tools";
  };

  outputs = {
    self,
      nixpkgs,
      home-manager,
      doomemacs,
      doom-config,
      catppuccin,
      catppuccin-wallpapers,
      nix-ai-tools,
      ...
  }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
      {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.ave70011 = import ./home;
              home-manager.extraSpecialArgs = {
                inherit inputs;
              };
            }
          ];
        };
      };
}
