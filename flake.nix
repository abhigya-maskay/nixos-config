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
    claude-code.url = "github:sadjow/claude-code-nix";
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
      claude-code,
      ...
  }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
      {
        packages.operator-mono = pkgs.stdenv.mkDerivation rec {
          pname = "operator-mono";
          version = "1.0.0";

          src = pkgs.fetchFromGithub {
            owner = "abhigya-maskay";
            repo = "fonts";
            rev = "62b8cc45ca0fa7f9798dd907d8400cd15bfe1d2a";
              sha256 = "thares";
          };

          installPhase = ''
            runHook preInstall
            mkdir -p $out/share/fonts/opentype
            find . -name "*.otf" -exec install -Dm644 {} -Dm644 {} -t $out/share/fonts/opentype/ \;
            runHook postinstall
          '';
          };
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
