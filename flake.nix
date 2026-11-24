{
  description = "nix-darwin + home-manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nix-darwin, home-manager, nix-homebrew, firefox-addons, ... }:
    let
      system = "aarch64-darwin";
      private = import ./hosts/private.nix;
      work = import ./hosts/work.nix;

      # System (sudo): bootstrap and rare changes
      mkDarwin = hostConfig: extraModules: nix-darwin.lib.darwinSystem {
        specialArgs = { inherit hostConfig; };
        modules = [ ./darwin.nix nix-homebrew.darwinModules.nix-homebrew ] ++ extraModules;
      };

      # User (no sudo): daily `home-manager switch`
      mkHome = hostConfig: home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = { inherit hostConfig firefox-addons; };
        modules = [ ./home.nix ];
      };
    in {
      darwinConfigurations = {
        private = mkDarwin private [ ];
        private-macos = mkDarwin private [ ./macos.nix ];
        work = mkDarwin work [ ];
        work-macos = mkDarwin work [ ./macos.nix ];
      };

      homeConfigurations = {
        private = mkHome private;
        work = mkHome work;
      };

      # pinned home-manager CLI for bootstrap.sh
      packages.${system}.home-manager = home-manager.packages.${system}.home-manager;
    };
}
