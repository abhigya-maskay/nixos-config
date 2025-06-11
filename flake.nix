{
  description = "nixos configuration";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
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
    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
    catppuccin = {
      url = "github:catppuccin/nix";
    };
    catppuccin-wallpapers = {
      url = "github:orangci/walls-catppuccin-mocha";
      flake = false;
    };
  };

  outputs = {
    self,
      nixpkgs,
      home-manager,
      doomemacs,
      doom-config,
      ghostty,
      catppuccin,
      catppuccin-wallpapers,
      ...
  }@inputs: {
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
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
      ];
    };
  };
}
